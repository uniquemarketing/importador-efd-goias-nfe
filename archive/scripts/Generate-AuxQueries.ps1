Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$workspace = Split-Path -Parent $PSScriptRoot
$schemaDir = Join-Path $workspace "00_Configuracoes\B_Schemas"
$auxDir = Join-Path $workspace "00_Configuracoes\C_Auxiliares"
$compatDir = Join-Path $auxDir "390_Compatibilidade"

$null = New-Item -ItemType Directory -Force -Path $auxDir
$null = New-Item -ItemType Directory -Force -Path $compatDir

$definitions = @(
    @{ Csv = "tb_pais.csv"; Query = "tb_pais"; Dim = "dim_pais" },
    @{ Csv = "tb_bacen_pais.csv"; Query = "tb_bacen_pais"; Dim = "dim_bacen_pais" },
    @{ Csv = "tb_municipios.csv"; Query = "tb_municipios"; Dim = "dim_municipio" },
    @{ Csv = "tb_cfop.csv"; Query = "tb_cfop"; Dim = "dim_cfop" },
    @{ Csv = "tb_cst_efd.csv"; Query = "tb_cst_efd"; Dim = "dim_cst_efd" },
    @{ Csv = "tb_orig_nfe.csv"; Query = "tb_orig_nfe"; Dim = "dim_orig_nfe" },
    @{ Csv = "tb_cst_nfe.csv"; Query = "tb_cst_nfe"; Dim = "dim_cst_nfe" },
    @{ Csv = "tb_csosn_nfe.csv"; Query = "tb_csosn_nfe"; Dim = "dim_csosn_nfe" },
    @{ Csv = "tb_cest.csv"; Query = "tb_cest"; Dim = "dim_cest" },
    @{ Csv = "tb_modelo_doc.csv"; Query = "tb_modelo_doc"; Dim = "dim_modelo_doc" },
    @{ Csv = "tb_situacao_doc.csv"; Query = "tb_situacao_doc"; Dim = "dim_situacao_doc" },
    @{ Csv = "tb_cod_aj_apur_icms.csv"; Query = "tb_cod_aj_apur_icms"; Dim = "dim_cod_aj_apur_icms" },
    @{ Csv = "tb_aj_info_val_doc_fiscal.csv"; Query = "tb_aj_info_val_doc_fiscal"; Dim = "dim_aj_info_val_doc_fiscal" }
)

$compatibilityAliases = @(
    @{ Name = "tb_3_2_1_pais"; Target = "tb_pais" },
    @{ Name = "tb_4_1_1_modelo_doc"; Target = "tb_modelo_doc" },
    @{ Name = "tb_4_1_2_situacao_doc"; Target = "tb_situacao_doc" },
    @{ Name = "tb_5_1_1_cod_aj_apur_icms"; Target = "tb_cod_aj_apur_icms" },
    @{ Name = "tb_5_3_aj_info_val_doc_fiscal"; Target = "tb_aj_info_val_doc_fiscal" },
    @{ Name = "tb_cst"; Target = "tb_cst_efd" }
)

function Write-Utf8NoBom {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Path,

        [Parameter(Mandatory = $true)]
        [string] $Content
    )

    $encoding = [System.Text.UTF8Encoding]::new($false)
    [System.IO.File]::WriteAllText($Path, $Content, $encoding)
}

function Format-MFieldName {
    param([string] $Name)

    $escaped = $Name.Replace('"', '""')
    return '#"' + $escaped + '"'
}

function Format-MText {
    param([string] $Value)

    $escaped = $Value.Replace('"', '""')
    return '"' + $escaped + '"'
}

function Get-ColumnProfile {
    param(
        [array] $Rows,
        [string] $ColumnName
    )

    $values =
        @(
            foreach ($row in @($Rows)) {
                $row.$ColumnName
            }
        )
    $nonEmpty = @($values | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    $nullable = @($nonEmpty).Count -lt @($values).Count
    $isDate =
        @($nonEmpty).Count -gt 0 -and
        @($nonEmpty | Where-Object { $_ -notmatch '^\d{4}-\d{2}-\d{2}$' }).Count -eq 0

    [PSCustomObject]@{
        ColumnName = $ColumnName
        Kind = if ($isDate) { "date" } else { "text" }
        Nullable = $nullable
    }
}

function Convert-CompactDateToIso {
    param([string] $Value)

    if ($Value -match '^\d{8}$') {
        return "{0}-{1}-{2}" -f $Value.Substring(4, 4), $Value.Substring(2, 2), $Value.Substring(0, 2)
    }

    return $Value
}

function Sanitize-Rows {
    param(
        [string] $QueryName,
        [array] $Rows
    )

    if ($QueryName -ne "tb_cfop") {
        return @($Rows)
    }

    $sanitized = New-Object System.Collections.Generic.List[object]

    foreach ($row in @($Rows)) {
        if (
            [string]::IsNullOrWhiteSpace($row.CFOP) -and
            $row.Descrição -match '^\d{8}$' -and
            $sanitized.Count -gt 0
        ) {
            $previous = $sanitized[$sanitized.Count - 1]
            if ([string]::IsNullOrWhiteSpace($previous.Início) -or $previous.Início -eq "1900-01-00") {
                $previous.Início = Convert-CompactDateToIso -Value $row.Descrição
            }
            continue
        }

        if ($row.PSObject.Properties.Name -contains "Início" -and $row.Início -eq "1900-01-00") {
            $row.Início = $null
        }

        if ($row.PSObject.Properties.Name -contains "INICIO" -and $row.INICIO -eq "1900-01-00") {
            $row.INICIO = $null
        }

        if ($row.PSObject.Properties.Name -contains "Fim" -and $row.Fim -eq "1900-01-00") {
            $row.Fim = $null
        }

        if ($row.PSObject.Properties.Name -contains "FIM" -and $row.FIM -eq "1900-01-00") {
            $row.FIM = $null
        }

        $sanitized.Add($row)
    }

    return $sanitized.ToArray()
}

function Format-MValue {
    param(
        [AllowNull()]
        [string] $Value,

        [string] $Kind
    )

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return "null"
    }

    if ($Kind -eq "date") {
        $date = [datetime]::ParseExact($Value, "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
        return "#date($($date.Year), $($date.Month), $($date.Day))"
    }

    return Format-MText -Value $Value
}

foreach ($definition in $definitions) {
    $csvPath = Join-Path $schemaDir $definition.Csv
    $rows = Sanitize-Rows -QueryName $definition.Query -Rows (Import-Csv -Path $csvPath -Delimiter ';')
    $columns = @($rows[0].PSObject.Properties.Name)
    $profiles = @($columns | ForEach-Object { Get-ColumnProfile -Rows $rows -ColumnName $_ })

    $typeLines =
        @($profiles | ForEach-Object {
            $fieldName = Format-MFieldName -Name $_.ColumnName
            $fieldType = if ($_.Nullable) { "nullable $($_.Kind)" } else { $_.Kind }
            "            $fieldName = $fieldType"
        })

    $rowLines =
        @($rows | ForEach-Object {
            $row = $_
            $parts =
                @($profiles | ForEach-Object {
                    $columnName = $_.ColumnName
                    Format-MValue -Value $row.$columnName -Kind $_.Kind
                })
            "            {" + ($parts -join ", ") + "}"
        })

    $queryLines = @(
        "let"
        "    Fonte = #table("
        "        type table ["
        ($typeLines -join ",`r`n")
        "        ],"
        "        {"
        ($rowLines -join ",`r`n")
        "        }"
        "    ),"
        "    Final = Fonte"
        "in"
        "    Final"
    )

    $queryPath = Join-Path $auxDir ($definition.Query + ".m")
    Write-Utf8NoBom -Path $queryPath -Content ($queryLines -join "`r`n")

    $dimLines = @(
        "let"
        "    Fonte = " + $definition.Query + ","
        "    Base = Table.SelectColumns(Fonte, {" + (($columns | ForEach-Object { Format-MText -Value $_ }) -join ", ") + "}, MissingField.Ignore),"
        "    Final = fxAux_ReordenarColunasSeguras(Base, {" + (($columns | ForEach-Object { Format-MText -Value $_ }) -join ", ") + "})"
        "in"
        "    Final"
    )

    $dimPath = Join-Path $auxDir ($definition.Dim + ".m")
    Write-Utf8NoBom -Path $dimPath -Content ($dimLines -join "`r`n")
}

foreach ($alias in $compatibilityAliases) {
    $aliasLines = @(
        "let"
        "    Fonte = " + $alias.Target
        "in"
        "    Fonte"
    )

    $aliasPath = Join-Path $compatDir ($alias.Name + ".m")
    Write-Utf8NoBom -Path $aliasPath -Content ($aliasLines -join "`r`n")
}
