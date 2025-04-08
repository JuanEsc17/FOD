program ej1;
var
   archivo:File of integer;
   nombreFisico:String;
   num:integer;
begin
    writeln('Ingrese el nombre de archivo');
    readln(nombreFisico);
    assign(archivo,nombreFisico);
    rewrite(archivo);
    readln(num);
    while(num<>30000)do begin
       write(archivo,num);
       readln(num);
    end;
    close(archivo);
end.
