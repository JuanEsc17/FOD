program acrosstheuniverse;
type
    celular = record
       codigo:integer;
       nombre:String[20];
       descr:String[50];
       marca:String[10];
       precio:real;
       stockMin:integer;
       stockDisp:integer;
    end;

    archivo = file of celular;

procedure menuDeOpciones(var arch:archivo; var carga:text);
var opcion:integer;
begin
     writeln('a- Crear archivo de celulares');
     writeln('b- Listar celulares con stock menor al minimo');
     writeln('c- Listar celulares que tengan descripcion proporcionada por el usuario');
     writeln('d-

