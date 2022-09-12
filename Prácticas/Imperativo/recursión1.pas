{
1.- Implementar un programa que invoque a los siguientes módulos.
a. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y los almacene 
en un vector con dimensión física igual a 10. (un caracter en cada vector)
b. Implementar un módulo que imprima el contenido del vector.
c. Implementar un módulo recursivo que imprima el contenido del vector.
d. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la 
cantidad de caracteres leídos. 
El programa debe informar el valor retornado.
e. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una 
lista con los caracteres leídos.
f. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en el mismo 
orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en orden 
inverso al que están almacenados.
}
program recursion1;
const
  dimF=10;
type
  rango=1..dimF;
  vector=array[rango]of char;
  lista=^nodo;  //lista=puntero
  nodo=record
    dato:char;
    sig:lista;
    ant:lista;  //lo encontré en internet, no sé si vale hacer esto
  end;

procedure secuencia(var v:vector;var dimL:integer);
var
  caracter:char;
begin
  writeln('Ingrese un carecter:');
  readln(caracter);
  if(caracter<>'.')and(dimL<dimF)then begin
    dimL:=dimL+1;
    v[dimL]:=caracter;
    secuencia(v,dimL);
  end;   
end;
procedure imprimir(v:vector;dimL:integer);
var i:integer;
begin
  for i:= 1 to dimL do
    write('-----');
  writeln;
  write('   ');
  write('Caracter:');  //no writeln
  for i:= 1 to dimL do begin
    write(v[i],'|');   //no writeln
  end;
  writeln;
  for i:= 1 to dimL do
    write('-----');
  writeln;
  writeln;
end;
procedure imprimirRecusivo(v:vector;dimL:integer;i:integer);
begin
  if(i<dimL)then begin
    write(v[i],'|');
    i:=i+1;
    imprimirRecusivo(v,dimL,i);
  end;
end;
{d. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la 
cantidad de caracteres leídos.}
function cantCaracteres():integer;
var caracter:char;
begin
  writeln('Ingrese caracter:');
  readln(caracter);
  if(caracter<>'.')then
    cantCaracteres:=cantCaracteres()+1; //la funcion misma se convierte en un contador
  else
    cantCaracteres:=0;
end;
{e. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una 
lista con los caracteres leídos.}
procedure agregarAdelante(var L:lista;car:char);
var nue:lista;
begin
  new(nue);
  nue^.dato:=car;
  nue^.sig:=L;
  L:=nue;
end;
procedure cargarLista(var L:lista);
var  caracter:char;
begin
  writeln('Ingrese caracter:');
  readln(caracter);
  if(caracter<>'.')then begin
    cargarLista(L);  //el recursivo
    agregarAdelante(L,caracter);
  end
  else
    L:=nil;
end;
{f. Implemente un módulo recursivo que reciba la lista generada en e. e imprima los valores de la lista en el 
mismo orden que están almacenados.}
procedure imprimirLista(L:lista);
begin
  if(L<>nil)then begin
    write(L^.dato, '|');
    imprimirLista(L^.sig);  //lo mismo que L:=L^.sig; imprimirLista(L);
  end;
end;
{g. Implemente un módulo recursivo que reciba la lista generada en e. e imprima los valores de la lista en orden 
inverso al que están almacenados.}
procedure imprimirInverso(L:lista);
begin
  if(L<>nil)then begin
    write(L^.dato, '|');
    imprimirInverso(L^.ant);
  end;
end;
var
  v:vector;
  dimL:integer;
  i:integer;
  L:lista;
begin
  dimL:=0;
  cant:=0;
  secuencia(v,dimL);
  imprimir(v,dimL);
  imprimirRecusivo(v,diml,i);
  cargarLista(L);
  imprimirLista(L);
  imprimirInverso(L);
end.
