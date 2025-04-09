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

procedure imprimir(c:celular);
begin
    writeln('-----------------------------');
    writeln('Codigo: ',c.codigo);
    writeln('Nombre: ',c.nombre);
    writeln('Descripcion: ',c.descr);
    writeln('Marca: ',c.marca);
    writeln('Precio: ',c.precio);
    writeln('Stock minimo: ',c.stockMin);
    writeln('Stock disponible: ',c.stockDisp);
end;

procedure crearArchivo(var arch:archivo; var carga:text);
var nombre:String; celular:celular;
begin
   reset(carga);
   writeln('Ingrese el nombre de archivo: ');
   read(nombre);
   assign(arch,nombre);
   rewrite(arch);
   while(not EOF(carga))do begin
      with celular do begin
         readln(carga, codigo, precio, marca);
         readln(carga, stockDisp, stockMin, descr);
         readln(carga, nombre);
      end;
      write(arch,celular);
   end;
   writeln('Archivo cargado');
   close(arch);
   close(carga);
end;

procedure listarSinStock(var arch:archivo);
var celular:celular;
begin
    reset(arch);
    while(not EOF(arch))do begin
        read(arch,celular);
        if(celular.stockDisp<celular.stockMin)then
           imprimir(celular);
    end;
    close(arch);
end;

procedure listarCelularesConDescripcion(var arch:archivo);
var descripcion:String[50]; c:celular; hay:boolean;
begin
    reset(arch);
    writeln('Ingrese una descripcion: ');
    read(descripcion);
    descripcion:= ' ' + descripcion;
    hay:=false;
    while(not EOF(arch))do begin
        read(arch,c);
        if(c.descr = descripcion)then
           imprimir(c);
    end;
    if(not hay)then
       writeln('No hay coincidencias');
    close(arch);
end;

procedure exportarArchivo(var arch:archivo; var carga:text);
var c:celular;
begin
   reset(arch);
   rewrite(carga);
   while(not EOF(arch))do begin
      read(arch,c);
      writeln(carga,c.codigo,' ',c.precio,' ',c.marca);
      writeln(carga,c.stockDisp,' ',c.stockMin,' ',c.descr);
      writeln(carga,c.nombre);
   end;
   close(arch);
   close(carga);
end;

procedure leerCelular(var c:celular);
var cod:integer;
begin
    with c do begin
		write ('codigo: '); readln (cod);
		if (codigo <> 0) then begin
			write ('precio: '); readln (precio);
			write ('marca: '); readln (marca);
			write ('stock disponible: '); readln (stockDisp);
			write ('stock minimo: '); readln (stockMin);
			write ('descripcion: '); readln (descr);
			write ('nombre del celu: '); readln (nombre);
		end;
		writeln ('');
	end;
end;

procedure agregarCelular(var arch:archivo);
var c:celular;
begin
    reset(arch);
    leerCelular(c);
    seek(arch,filesize(arch));
    while(c.codigo<>0)do begin
       write(arch,c);
       leerCelular(c);
    end;
    close(arch);
end;

procedure modificarStock(var arch:archivo);
var nombre:String[20]; listo:boolean; celu:celular; stock:integer;
begin
    reset(arch);
    writeln('Ingrese nombre de celular: ');
    read(nombre);
    listo:=false;
    while((not listo) and (not EOF(arch))) do begin
       read(arch,celu);
       if(celu.nombre = nombre)then begin
          listo:=true;
          writeln('Ingrese el stock nuevo: ');
          read(stock);
          celu.stockDisp:=stock;
          seek(arch,filesize(arch)-1);
          write(arch,celu);
       end;
    end;
    if (not listo) then writeln('No se encontraron coincidencias');
    close(arch);
end;

procedure exportarSinStock(var arch:archivo);
var sinStock:text; c:celular;
begin
   assign(sinStock,'C:\Users\treji\Desktop\FOD\Practica 1\Ej6\SinStock.txt');
   reset(arch);
   rewrite(sinStock);
   while(not EOF(arch))do begin
      read(arch,c);
      if(c.stockDisp = 0)then begin
         writeln(sinStock,c.codigo,' ', c.precio,' ',c.marca);
         writeln(sinStock,c.stockDisp,' ',c.stockMin,' ',c.descr);
         writeln(sinStock,c.nombre);
      end;
   end;
   close(arch);
   close(sinStock);
end;

procedure menuDeOpciones(var arch:archivo; var carga:text);
var opcion:integer;
begin
     writeln('--------------Menu--------------');
     writeln('1- Crear archivo de celulares');
     writeln('2- Listar celulares con stock menor al minimo');
     writeln('3- Listar celulares que tengan descripcion proporcionada por el usuario');
     writeln('4- Exportar archivo a celulares.txt');
     writeln('5- Agregar celular al final del archivo');
     writeln('6- Modificar el stock de un celular');
     writeln('7- Exportar el contenido de arch a SinStock.txt');
     writeln('8- Salir');
     writeln('Selecciona una opcion: '); read(opcion);
     while(opcion<>8)do begin
        case opcion of
           1: crearArchivo(arch,carga);
           2: listarSinStock(arch);
           3: listarCelularesConDescripcion(arch);
           4: exportarArchivo(arch,carga);
           5: agregarCelular(arch);
           6: modificarStock(arch);
           7: exportarSinStock(arch);
        else
           writeln('OPCION NO VALIDA');
        end;
        writeln('1- Crear archivo de celulares');
        writeln('2- Listar celulares con stock menor al minimo');
        writeln('3- Listar celulares que tengan descripcion proporcionada por el usuario');
        writeln('4- Exportar archivo a celulares.txt');
        writeln('5- Agregar celular al final del archivo');
        writeln('6- Modificar el stock de un celular');
        writeln('7- Exportar el contenido de arch a SinStock.txt');
        writeln('8- Salir');
        writeln('Selecciona una opcion: '); read(opcion);
   end;
end;

var
   carga:text;
   arch:archivo;
begin
    assign(carga,'C:\Users\treji\Desktop\FOD\Practica 1\Ej5\celulares.txt');
    menuDeOpciones(arch,carga);
end.
