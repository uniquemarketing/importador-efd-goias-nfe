let
    Fonte = (
   ColDate as  date 
)=>
    let
        
        dataTransf = 
        try
            let
                Ano = Text.From(Date.Year(ColDate)),
                Mes = Text.PadStart(Text.From(Date.Month(ColDate)),2,"0"),
                
               Periodo = Number.From(Ano&Mes)
            in
        Periodo
    otherwise null

    in
        dataTransf
in
    Fonte

