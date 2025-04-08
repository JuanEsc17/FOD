program ej3;
type
    empleado = record
       numEmpl:integer;
       apellido:String[20];
       nombre:String[20];
       edad:integer;
       DNI:String[8];
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
    writeln('Numero de empleado: ',e.numEmpl);
end;

procedure empleadosConcretos(var arch:arch);
 function esCorrecto(nombre:String;apellido:String; nombreApell:String):boolean;
 begin
    esCorrecto:=(nombre=nombreApell)or(apellido=nombreApell);
 end;
var nombreApell:String; e:empleado; aux:boolean;
begin
     writeln('Ingrese el nombre o apellido');
     readln(nombreApell);
     writeln('Empleados:');
     reset(arch);
     aux:=false;
     while(not EOF(arch))do begin
        read(arch,e);
        if(esCorrecto(e.nombre,e.apellido,nombreApell))then begin
           imprimirEmpleado(e);
           aux:=true;
        end;
     end;
     if(not aux)then writeln('Empleado no encontrado');
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

procedure anadirEmpleados(var arch:arch);
   function sePuede(var archi:file of empleado; num:integer):boolean;  //Si no le pongo file of empleado tira error (????))
   var aux:boolean; emp:empleado;
   begin
       aux:=false;
       while((not EOF(archi)) and (not aux)) do begin
          read(archi,emp);
          if (emp.numEmpl = num) then
             sePuede:=false;
       end;
       sePuede:=true;
   end;
var e:empleado;
begin
    reset(arch);
    writeln('Ingrese empleados, ingrese "fin" para terminar');
    leerEmpleado(e);
    while(e.apellido<>'fin')do begin
       if(sePuede(arch,e.numEmpl))then begin
          Seek(arch,FileSize(arch));
          write(arch,e);
       end
       else writeln('ese empleado ya existe');
       leerEmpleado(e);
    end;
    close(arch);
end;

procedure modificarEdad(var arch:arch);
var num:integer; edad:integer; e:empleado; sigo:boolean;
begin
    reset(arch);
    writeln('Ingrese un numero de empleado: ');
    read(num);
    sigo:=true;
    while(not EOF(arch))and(sigo)do begin
       read(arch,e);
       if(e.numEmpl=num)then begin
          writeln('Ingrese la edad: ');
          read(edad);
          e.edad:=edad;
          Seek(arch,filePos(arch)-1);
          write(arch,e);
          sigo:=false;
       end;
    end;
    if(sigo)then writeln('No se hayo el empleado numero: ',num)
    else writeln('Se modifico la edad del empleado numero : ',num);
    close(arch);
end;

procedure exportarArchivo(var arch:arch);
var todos:text; e:empleado;
begin
   assign(todos,'C:\Users\treji\Desktop\FOD\Practica 1\todos_empleados.txt');
   rewrite(todos);
   reset(arch);
   while(not EOF(arch)) do begin
      read(arch,e);
      writeln(todos,'Numero de empleado: ',e.numEmpl,'. Apellido y nombre: ',e.apellido,' ',e.nombre,'. Edad: ',e.edad,'. DNI:',e.dni);
   end;
   writeln('Archivo exportado');
   close(arch);
   close(todos);
end;

procedure exportarDNIs(var arch:arch);
var e:empleado; dnis:text;
begin
    assign(dnis,'C:\Users\treji\Desktop\FOD\Practica 1\faltaDNIEmpleado.txt');
    rewrite(dnis);
    reset(arch);
    while(not EOF(arch))do begin
       read(arch,e);
       if(e.DNI = '00')then
          write(dnis,'Numero de empleado: ',e.numEmpl,'. Apellido y nombre: ',e.apellido,' ',e.nombre,'. Edad: ',e.edad,'. DNI:',e.dni);
    end;
    close(arch);
    close(dnis);
end;

var
   archivo:arch;
   e:empleado;
   nombre:String;
   opcion:integer;
begin
    writeln('Ingrese nombre de archivo');
    readln(nombre);
    assign(archivo,nombre);
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
    writeln('4- Anadir empleados');
    writeln('5- Modificar edad de un empleado');
    writeln('6- Exportar archivo a todos_empleados.txt');
    writeln('7- Exportar empleados a faltaDNIEmpleado.txt los que no tienen DNI');
    writeln('8- Salir');
    write('Ingrese una opcion: '); readln(opcion);
    while(opcion<>8)do begin
       case opcion of
          1: empleadosConcretos(archivo);
          2: todosLosEmpleados(archivo);
          3: proximosAJubilar(archivo);
          4: anadirEmpleados(archivo);
          5: modificarEdad(archivo);
          6: exportarArchivo(archivo);
          7: exportarDNIs(archivo);
       else
          writeln('Opcion invalida');
       end;
       writeln();
       writeln('-----------------');
       writeln('1- Listar en pantalla empleados en concreto');
       writeln('2- Listar en pantalla todos los empleados');
       writeln('3- Listar en pantalla empleados proximos a jubilarse');
       writeln('4- Anadir empleados');
       writeln('5- Modificar edad de un empleado');
       writeln('6- Exportar archivo a todos_empleados.txt');
       writeln('7- Exportar empleados a faltaDNIEmpleado.txt los que no tienen DNI');
       writeln('8- Salir');
       write('Ingrese una opcion: '); readln(opcion);
    end;
end.
