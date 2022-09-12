{Una biblioteca nos ha encargado procesar la información de los préstamos realizados durante cada año 2021.De cada préstamo 
se conoce el isbn del libro,el número de socio,el día y mes del préstamo y cantidad de días prestados.Implementar un 
programa con:
a)Un módulo que lea préstamos y retorne en una estructura adecuada la información de los préstamos organizada por mes.Para 
cada mes los préstamos deben quedar ordenados por isbn.La lectura de los préstamos finaliza con isbn-1.
b)Un módulo recursivo que reciba la estructura generada en a. y muestre, para cada mes,isbn y número de socio.
c)Un módulo que reciba la estructura generada en a. y retorne una nueva estructura con todos los préstamos ordenados por
isbn.
d)Un módulo recursivo que reciba la estructura generada en c. y muestre todos los isbn y número de socio correspondiente.
e)Un módulo que reciba la estructura generada en a. y retorne una nueva estructura ordenada isbn, donde cada isbn aparezca 
una vez junto a la cantidad total de veces que se prestó durante el año 2021.
f)Un módulo recursivo que reciba la estructura generada en e. y muestre su contenido.S
}
program merge1;  //organizada por mes sería agrupados por mes 
type
  rangoD=1..31;
  rangoM=1..12;
  prestamo=record
    isbn:integer;
    numero:integer;
    dia:rangoD;
    mes:rangoM;
    cantDias:integer;
  end;
  guardar=record
    isbn:integer;
    numero:integer;
    dia:rangoD;
    cantDias:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:guardar;
    sig:lista;
  end;
  vector=array[rangoM]of lista;
  regAcu=record
    isbn:integer;    //ordenada por isbn
    cantPrestamos:integer;  //cant total
  end;
  listaAcu=^nodoAcu;
  nodoAcu=record
    dato:regAcu;
    sig:listaAcu;
  end;

procedure leerPrestamo(var p:prestamo);
begin
  writeln('Ingrese isbn del libro:');
  readln(p.isbn);
  if(p.isbn<>-1)then begin
    p.numero:=random(10);
    p.dia:=random(30)+1;
    p.mes:=random(10)+2;
    p.cantDias:=random(10)+5;
  end;
end;
procedure insertarOrdenado(var L:lista;p:prestamo);
var nue,ant,act:lista;
begin
  new(nue);
  nue^.dato:=p;
  ant:=L;
  act:=L;
  while(act<>nil)and(act^.dato.isbn<p.isbn)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(ant=act)then L:=nue
             else ant^.sig:=nue;
  nue^.sig:=act;
end;
procedure inicializar(var v:vector);
var i:rangoM;
begin
  for i:=1 to 12 do 
    v[i]:=nil; 
end;
procedure pasarDatos(p:restamo;var g:guardar);
begin
  g.isbn:=p.isbn;
  g.numero:=p.numero;
  g.dia:=p.dia;
  g.cantDias:=p.cantDias;
end;
procedure cargarVectorDeLista(var v:vector);
var p:prestamo;
begin
  inicializar(v);
  leerPrestamo(p);
  while(p.isbn<>-1)do begin
    pasarDatos(p.g);
    insertarOrdenado(v[p.mes],g);  //organizado por mes, ordenados por isbn
    leerPrestamo(P);
  end;
end;
{b)Un módulo recursivo que reciba la estructura generada en a. y muestre, para cada mes,isbn y número de socio.}
procedure mostrar(L:lista);
begin
  
    if(L<>nil)then begin 
      writeln('ISBN:',L^.dato.isbn,' numero:',L^.dato.numero);
      mostrar(L^.sig);
    end;
  end;
end;
procedure imprimir(v:vector);
var i:;.
begin
  for i:=1 to 12 do begin
    mostrar(v[i]);
end;
{c)Un módulo que reciba la estructura generada en a. y retorne una nueva estructura con todos los préstamos ordenados por
isbn.}
procedure minimo(var v:vector;var p:prestamo); //juntar todos los prestamos 
var
  i,pos:integer;
begin
  p.isbn:=999;
  for i:=1 to 12 do begin
    if(v[i]<>nil)and(v[i]^.dato.isbn<=p.isbn)then begin
      p:=v[i]^.dato;
      pos:=i;
    end;
    if(p.isbn<>999)then begin
      v[pos]:=v[pos]^.sig;
    end;
  end;
end;
procedure agregarAtras(var L,ult:lista;p:prestamo);
var nue:lista;
begin
  new(nue);
  nue^.dato:=p;
  nue^.sig:=nil;
  if(L=nil)then  L:=nue;
           else  ult^.sig:=nue;
  ult:=nue;
end;
procedure merge(v:vector;var nuevaLista:lista);
var p:prestamo;ult:lista;
begin
  nuevaLista:=nil;
  minimo(v,p);
  while(p.isbn<>999)do begin
    agregarAtras(nuevaLista,ult,p);
    minimo(v,p);
  end;
end;
{d)Un módulo recursivo que reciba la estructura generada en c. y muestre todos los isbn y número de socio correspondiente.}
procedure mostrarC(L:lista);
begin
  if(L<>nil)then begin
    writeln('ISBN:',L^.dato.isbn,' numero:',L^.dato.numero);
    mostrarC(L^.sig);
  end;
end;
{e)Un módulo que reciba la estructura generada en a. y retorne una nueva estructura ordenada isbn, donde cada isbn aparezca 
una vez junto a la cantidad total de veces que se prestó durante el año 2021.}
procedure agregarAtras2(var L,ult:listaAcu;reg:regAcu);
var nue:listaAcu;
begin
  new(nue);
  nue^.dato:=reg;
  nue^.sig:=nil;
  if(L=nil)then  L:=nue;
           else  ult^.sig:=nue;
  ult:=nue;
end;
procedure mergeAcumulador(v:vector;var L:listaAcu);
var  pMin:guardar;ult:listaAcu;actual:regAcu;
begin
  L:=nil;
  minimo(v,pMin);
  while(pMin.isbn<>999)do begin
    actual.isbn:=pMin.isbn;
    actual.cantPrestamos:=0;
    while(actual.isbn= pMin.isbn)do begin
      actual.cantPrestamos:=actual.cantPrestamos+1;
      minimo(v,pMin);
    end;
    agregarAtras2(L,ult,actual);
  end;     
end;
var 
  v:vector;
  nuevaL:lista;
begin  
  Randomize;
  cargarLista(v);  
  mostrar(v);
  merge(v,nuevaL);
  mostrarC(nuevaL);
  mergeAcumulador(v,nuevaL);
end.
