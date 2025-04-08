program ej1;
var
   archivo:File of integer;
   nombreFisico:String;
   num,suma,total,contMenores:integer;
begin
    writeln('Ingrese el nombre de archivo');
    readln(nombreFisico);
    assign(archivo,nombreFisico);
    reset(archivo);
    suma:=0;
    contMenores:=0;
    total:=0;
    while(not EOF(archivo))do begin
       read(archivo,num);
       if(num<1500)then
          contMenores:=contMenores+1;
       suma:=suma+num;
       total:=total+1;
       writeln(num);
    end;
    writeln('Promedio: ',suma/total:2:2);
    readln(num);//esto es para poder llegar a ver el resultado promedio je
    close(archivo);
end.
