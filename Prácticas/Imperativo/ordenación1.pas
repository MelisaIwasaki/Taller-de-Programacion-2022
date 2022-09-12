{
1.- Implementar un programa que procese la información de las ventas de productos de un comercio(como máximo 20). 
De cada venta se conoce código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades). 
El ingreso de las ventas finaliza con el código 0 (no se procesa).
a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la 
cantidad se debe leer. 
b. Mostrar el contenido del vector resultante.
c. Ordenar el vector de ventas por código.
d. Mostrar el contenido del vector resultante.
e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como 
parámetros. 
f. Mostrar el contenido del vector resultante.
g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso
    e., sólo para los códigos pares.
h. Mostrar la lista resultante.
}
program ordenacion1;
const
  dimF=5;  //20;
type
  rango= 1..dimF;
  rangoC= 0..15;
  rangoU= 1..99;
  venta= record
    codigo:rangoC;
    cantidad:rangoU;
  end;
  tipo= venta;
  vector= array[rango]of tipo;
  lista=^nodo;
  nodo=record
    dato:tipo;
    sig:lista;
  end;
  
procedure leer(var e:venta);
begin
  Randomize;
  write('Codigo:');
  e.codigo:=random(16);
  writeln(e.codigo);
  writeln('Ingrese la cantidad:');
  readln(e.cantidad);
end;
procedure cargar(var v:vector;var dimL:integer);
var e:venta;
begin
  dimL:=0;
  leer(e);
  while(e.codigo<>0)and(dimL<dimF)do begin
    dimL:= dimL+1;
    v[dimL]:=e;
    leer(e);
  end;
end;
procedure mostrar(v:vector;dimL:integer);
var i:rango;
begin
  for i:= 1 to dimL do
    write('-----'); //NO writeln
  writeln;
  write(' ');
  writeln('Codigo:');
  for i:= 1 to dimL do begin
    if(v[i].codigo<=9)then
      write('0');
    write(v[i].codigo,' | ');
  end;
  writeln;
  writeln;
  write(' ');
  writeln('Cantidad: ');
  for i:= 1 to dimL do begin
    if(v[i].cantidad<=9)then
      write('0');
    write(v[i].cantidad,' | ');
  end;
  writeln;
  for i:=1 to dimL do
    write('-----');
  writeln;
  writeln;
end;
procedure ordenar(var v:vector;dimL:integer);
var i,j,pos:rango; item:tipo;
begin
  for i:= 1 to dimL-1 do begin
    pos:=i;
    for j:=i+1 to dimL do
      if(v[j].codigo<v[pos].codigo)then
        pos:=j;
    item:=v[pos];
    v[pos]:= v[i];
    v[i]:= item;
  end;
end;
procedure eliminar(var v:vector;var dimL:integer;valorInferior,valorSuperior:integer);
var
  i,j,pos:rango;
begin
  pos:=0;
  i:=1;
  while(i<=dimL)and(v[i].codigo < valorInferior)do
    i:=i+1;  
  j:=i; 
  while(i<=dimL)and(v[i].codigo <= valorSuperior)do
    i:=i+1; 
  pos:= i- j; 
  for i:= (j+pos)to dimL do
    v[i-pos]:=v[i];
  dimL:=dimL-pos;
end;
procedure agregarAtras(var L,ult:lista; e:venta);
var 
  nue:lista;
begin
  new(nue);
  nue^.dato:= e;
  nue^.sig:=nil;
  if(L=nil)then  L:=nue
           else  ult^.sig:=nue;
  ult:= nue;
end;
procedure GenerarLista(v:vector;dimL:integer;var L:lista);
var
  i:integer;ult:lista;
begin
  for i:= 1 to dimL do begin
    if((v[i].codigo mod 2 )=0)then
      agregarAtras(L,ult,v[i]);
  end;
end;

procedure ImprimirLista(L:lista);
begin
  writeln('Lista:');
  while(L<>nil)do begin
    writeln('codigo: ',L^.dato.codigo,'cantidad: ',L^.dato.cantidad);
    L:=L^.sig;
  end;
end;
var 
  v:vector;
  dimL:integer;
  valorInferior,valorSuperior:integer;
  L:lista;
begin
  L:=nil;
  cargar(v,dimL);
  mostrar(v,dimL);
  ordenar(v,dimL);
  mostrar(v,dimL);
  writeln('Ingrese valor inferior:');
  readln(valorInferior);
  writeln('Ingrese valor superior:');
  readln(valorSuperior);
  eliminar(v,dimL,valorInferior,valorSuperior);
  mostrar(v,dimL);
  GenerarLista(v,dimL,L);
  ImprimirLista(L);
end.
