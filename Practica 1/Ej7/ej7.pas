program ej7;
type
   novela = record
      codigo:integer;
      nombre:String[20];
      genero:String[10];
      precio:real;
   end;

   archivo = file of novela;

procedure crearArchivo(var arch:archivo;var novelas:text);
var nombre:String; n:novela;
begin
    writeln('Ingrese nombre de archivo');
    readln(nombre);
    assign(arch,nombre);
    reset(novelas);
    rewrite(arch);
    while(not eof(novelas))do begin
      readln(novelas, n.codigo,n.precio,n.genero);
      readln(novelas, n.nombre);
      write(arch,n);
   end;
   writeln('Archivo cargado');
   close(novelas);
   close(arch);
end;

procedure actualizar(var n:novela);
begin
    writeln('Ingrese nombre: ');
    readln(n.nombre);
    writeln('Ingrese codigo: ');
    readln(n.codigo);
    writeln('Ingrese genero: ');
    readln(n.genero);
    writeln('Ingrese precio: ');
    readln(n.precio);
end;

procedure actualizarNovela(var arch:archivo);
var codigo:integer; encontre:boolean; n:novela;
begin
   writeln('Ingrese el codigo de la novela');
   readln(codigo);
   reset(arch);
   encontre:=false;
   while((not EOF(arch)) and (not encontre))do begin
      read(arch,n);
      if(n.codigo = codigo)then begin
         actualizar(n);
         encontre:=true;
         seek(arch,filepos(arch)-1);
         write(arch,n);
         writeln('Se modifico la novela');
      end;
   end;
   close(arch);
end;

procedure leerNovela(var n:novela);
begin
    writeln('Ingresa codigo: ');
    readln(n.codigo);
    if(n.codigo<>0)then begin
        writeln('Ingresa nombre: ');
        readln(n.nombre);
        writeln('Ingresa genero: ');
        readln(n.genero);
        writeln('Ingresa precio: ');
        readln(n.precio);
    end;
end;

procedure agregarNovela(var arch:archivo);
var n:novela;
begin
   reset(arch);
   leerNovela(n);
   seek(arch,fileSize(arch));
   while(n.codigo<>0)do begin
      write(arch,n);
      leerNovela(n);
   end;
   close(arch);
end;

procedure exportarArchivo(var arch:archivo; var novelas:text);
var n:novela;
begin
   reset(arch);
   rewrite(novelas);
   while(not EOF(arch))do begin
      read(arch,n);
      writeln(novelas,n.codigo,' ',n.precio:0:2,' ',n.genero);
      writeln(novelas,n.nombre);
   end;
   close(arch);
   close(novelas);
end;

procedure menuDeOpciones(var arch:archivo; var novelas:text);
var opcion:integer;
begin
   writeln('----------MENU-----------');
   writeln('1- Crear archivo binario');
   writeln('2- Actualizar novela');
   writeln('3- Agregar novela');
   writeln('4- Exportar archivo binario a .txt');
   writeln('5- Salir');
   writeln('Ingrese opcion: '); readln(opcion);
   while(opcion<>5)do begin
      case opcion of
         1: crearArchivo(arch,novelas);
         2: actualizarNovela(arch);
         3: agregarNovela(arch);
         4: exportarArchivo(arch,novelas);
      else
         writeln('Opcion no valida');
      end;
      writeln('----------MENU-----------');
      writeln('1- Crear archivo binario');
      writeln('2- Actualizar novela');
      writeln('3- Agregar novela');
      writeln('4- Exportar archivo binario a .txt');
      writeln('5- Salir');
      writeln('Ingrese opcion: '); readln(opcion);
   end;
end;

var
   arch:archivo;
   novelas:text;
begin
    assign(novelas,'C:\Users\treji\Desktop\FOD\Practica 1\Ej7\novelas.txt');
    menuDeOpciones(arch,novelas);
end.
