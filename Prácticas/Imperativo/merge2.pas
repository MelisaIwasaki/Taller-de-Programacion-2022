{Un cine posee la lista de películas que se proyectará durante el mes de octubre.De cada película se conoce:código de 
película,código de género(1:acción,2:aventura,3:drama,4:suspenso,5:comedia ,6:bélica,7:docuental,8:terror)y puntaje 
promedio otorgado por las críticas.Implementar un prgrama que contenga:
a)Un módulo que lea los datos de películas y lo almacene ordenados por código de película y agrupadaos por código de
género, en una estructura de datos adecuada.La lectura finaliza cuando se lee el código de película -1.
b)Un módulo que reciba la estructura generada en a. y retorne una estructura de datos donde estén todas las películas 
almacenadas ordenadas por código de película.
}
program merge2; 
type
  rango=1..8;
  pelicula=record
    codPeli:integer;
    codGen:rango;
    puntaje:real;
  end;
  lista=^nodo;
  nodo=record
    dato:pelicula;
    sig:lista;
  end;
  vector=array[rango]of lista;
  
procedure leerPeli(var p:pelicula);
begin
  writeln('Ingrese codigo de pelicula:');
  readln(p.codPeli);
  if(p.codPeli<>-1)then begin
    writeln('Ingrese codigo de genero:');
    readln(p.codGen);
    writeln('Ingrese puntaje:');
    readln(p.puntaje);
  end;
end;
procedure insertarOrdenado(var L:lista;p:pelicula);
var
  nue,ant,act:lista;
begin
  new(nue);
  nue^.dato:=p;
  ant:=L;
  act:=L;
  while(act^.dato.codPeli<p.codPeli)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(ant=act)then L:=nue
             else ant^.sig:=nue;
  nue^.sig:=act;
end;
procedure inicializar(var v:vector);
var i:rango;
begin
  for i:=1 to 8 do 
    v[i]:=nil;
end;
procedure cargarAgrupado(var v:vector);
var p:pelicula;
begin
  leerPeli(p);
  while(p.codPeli<>-1)do begin
    insertarOrdenado(v[p.codGen],p);
    leerPeli(p);
  end;
end;
{b)Un módulo que reciba la estructura generada en a. y retorne una estructura de datos donde estén todas las 
películas almacenadas ordenadas por código de película.} 
procedure agregarAtras(var L,ult:lista;p:pelicula);
var nue:lista;
begin
  new(nue);
  nue^.dato:=p;
  nue^.sig:=nil;
  if(L=nil)then  L:=nue
           else  ult^.sig:=nue;
  ult:=nue;
end;
procedure minimo(var v:vector;var p:pelicula);
var i,pos:integer;L:lista;
begin
  p.codPeli:=999;
  pos:=-1;
  for i:=1 to 8 do
    L:=v[i];
    if(L<>nil)and(L^.dato.codPeli<=p.codPeli)then begin
      p.codPeli:=L^.dato.codPeli;
      pos:=i;
    end;
    if(pos<>-1)then
      p.codGen:=v[pos]^.dato.codGen;
      p.puntaje:=v[pos]^.dato.puntaje;
      v[pos]:=v[pos]^.sig;
end;
procedure merge(v:vector;var nuevaL:lista);
var ult:lista;p:pelicula;
begin
  minimo(v,p);
  while(p.codPeli<>999)do begin
    agregarAtras(nuevaL,ult,p);
    minimo(v,p);
  end;
end;
var
  v:vector;
  nuevaL:lista;
begin
  nuevaL:=nil;
  inicializar(v);
  cargarAgrupado(v);
  merge(v,nuevaL);
end.
