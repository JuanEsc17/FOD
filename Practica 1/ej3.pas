program ej3;
type
    empleado = record
       numEmpl:integer;
       apellido:String;
       nombre:String;
       edad:integer;
       DNI:integer;
    end;
    arch = file of empleado;
procedure leerEmpleado(var e:empleado);
begin
     writeln('Ingrese apellido');
     readln(e.apellido);
     if(e.apellido<>'fin')then begin
        writeln('Ingrese nombre');
        readln(e.nombre);
        writeln('Ingrese edad');
        readln(e.edad);
        writeln('Ingrese numero de empleado');
        readln(e.numEmpl);
        writeln('Ingrese DNI');
        readln(e.DNI);
     end;
end;

procedure imprimirEmpleado(e:empleado);
begin
    writeln('-----------------');
    writeln('Nombre: ',e.nombre);
    writeln('Apellido: ',e.apellido);
    writeln('DNI: ',e.DNI);
    writeln('Edad: ',e.edad);
    writeln('Numero de empleado',e.numEmpl);
end;

procedure empleadosConcretos(var arch:arch);
 function esCorrecto(nombre:String;apellido:String; nombreApell:String):boolean;
 begin
    esCorrecto:=(nombre=nombreApell)or(apellido=nombreApell);
 end;
var nombreApell:String; e:empleado;
begin
     writeln('Ingrese el nombre o apellido');
     readln(nombreApell);
     writeln('Empleados:');
     reset(arch);
     while(not EOF(arch))do begin
        read(arch,e);
        if(esCorrecto(e.nombre,e.apellido,nombreApell))then
           imprimirEmpleado(e);
     end;
     close(arch);
end;

procedure todosLosEmpleados(var arch:arch);
var e:empleado;
begin
   reset(arch);
   while(not EOF(arch))do begin
      read(arch,e);
      imprimirEmpleado(e);
   end;
   close(arch);
end;

procedure proximosAJubilar(var arch:arch);
   function esCorrecto(edad:integer):boolean;
   begin
      esCorrecto:=edad>70;
   end;
var e:empleado;
begin
   reset(arch);
   while(not EOF(arch))do begin
      read(arch,e);
      if(esCorrecto(e.edad))then
         imprimirEmpleado(e);
   end;
   close(arch);
end;
var
   archivo:arch;
   e:empleado;
   nombre:String;
   opcion:integer;
begin
    writeln('Ingrese nombre de archivo');
    readln(nombre);
    assign(archivo,nombre);   //C:\Users\treji\Desktop\FOD\prueba.txt
    reset(archivo);
    leerEmpleado(e);
    while(e.apellido<>'fin')do begin
       write(archivo,e);
       leerEmpleado(e);
    end;
    close(archivo);
    writeln('-----------------');
    writeln('1- Listar en pantalla empleados en concreto');
    writeln('2- Listar en pantalla todos los empleados');
    writeln('3- Listar en pantalla empleados proximos a jubilarse');
    writeln('4- Salir');
    write('Ingrese una opcion: '); readln(opcion);
    while(opcion<>4) do begin
       case opcion of
          1: empleadosConcretos(archivo);
          2: todosLosEmpleados(archivo);
          3: proximosAJubilar(archivo);
       else
          writeln('Opcion invalida');
       end;
       writeln();
       writeln('-----------------');
       writeln('1- Listar en pantalla empleados en concreto');
       writeln('2- Listar en pantalla todos los empleados');
       writeln('3- Listar en pantalla empleados proximos a jubilarse');
       writeln('4- Salir');
       write('Ingrese una opcion: '); readln(opcion);
    end;
end.
