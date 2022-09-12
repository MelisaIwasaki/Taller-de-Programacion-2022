{
3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100. 
Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso
en caso contrario. 
}
program recursion3;
type
  lista=^nodo;
  nodo=record
    dato:integer;
    sig:lista;
  end;
procedure agregarAdelante(var L:lista;num:integer);
var nue:lista;
begin 
  new(nue);
  nue^.dato:=num;
  nue^.sig:=L;
  L:=nue;
end;
procedure generarLista(var L:lista); 
var num:integer;
begin
    num:=random(100)+0;   //no necesitaba recorrer la lista 
    if(num<>0)then begin  //if(L<>nil)then,tampoco L^.sig
      generarLista(L);
      agregarAdelante(L,num);
    end
    else
      L:=nil;
end;
procedure mostrar(L:lista);
begin
  if(L<>nil)then begin
    write(L^.dato, '|');
    mostrar(L^.sig);
  end;
end;
procedure minimo(L:lista;var min:integer);
begin
  if(L<>nil)then begin
    if(L^.dato<min)then begin
      min:=L^.dato;
    end;
    minimo(L^.sig,min);
  end;
end;
procedure maximo(L:lista;var max:integer);
begin
  if(L<>nil)then begin
    if(L^.dato>max)then begin
      max:=L^.dato;
    end;
    maximo(L^.sig,max);
  end;
end;
function buscar(L:lista;x:integer):boolean;
begin
  if(L=nil)then  buscar:=false
  else
    if(L^.dato=x)then  buscar:=true
    else
      buscar:=buscar(L^.sig,x);
end;
var 
  L:lista;
  min,max,x:integer;
begin
  L:=nil;
  min:=999;
  max:=-1;
  generarLista(L);
  mostrar(L);
  minimo(L,min);
  maximo(L,max);
  writeln('El minimo:',min);
  writeln('El maximo:',max);
  writeln('Ingrese un numero a buscar:');
  readln(x);
  if(buscar(L,x))then
    writeln('Se encontro')
  else
    writeln('No se encontro');
end.
