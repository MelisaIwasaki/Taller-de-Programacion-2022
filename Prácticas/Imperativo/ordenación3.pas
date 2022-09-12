{
3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022. 
De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 
5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas. 
Implementar un programa modularizado que:
a. Lea los datos de películas y los almacene por orden de llegada y agrupados por código de género, en una 
estructura de datos adecuada. La lectura finaliza cuando se lee el código de la película -1. 
b. Una vez almacenada la información, genere un vector que guarde, para cada género, el código de película con 
mayor puntaje obtenido entre todas las críticas.
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos en la 
teoría. 
d. Luego de ordenar el vector, muestre el código de película con mayor puntaje y el código de película con menor
puntaje.
}
 //agrupados:vector de lista

program ordenacion3; //Arreglar
const
  dimF=8;
type
  rango=1..dimF;
  pelicula=record
    codPeli:integer;
    codGen:rango;
    puntaje:real;
  end;
  tipo=pelicula;
  lista=^nodo;
  nodo=record
    dato:tipo;
    sig:lista;
  end;
  vector=array[rango]of lista;
  
  peliMax=record
    codPeli:integer;
    puntaje:real;
  end;
  tipoMax=peliMax;
  vCriticas=array[rango]of tipoMax;
  
procedure leer(var t:tipo);
begin
  writeln('Ingrese codigo de pelicula:');
  readln(t.codPeli);
  if(t.codPeli<>-1)then begin
    writeln('Ingrese codigo de genero:');
    readln(t.codGen);
    writeln('Ingrese puntaje promedio:');
    readln(t.puntaje);
  end;
end;
procedure agregarAtras(var L,ult:lista;t:tipo);
var nue:lista;
begin
  new(nue);
  nue^.dato:=t;
  nue^.sig:=nil;
  if(L=nil)then L:=nue
           else ult^.sig:=nue;
  ult:=nue;
end;
procedure inicializarV(var v:vector);
var i:rango;
begin
  for i:= 1 to dimF do
    v[i]:=nil;
end;
procedure cargar(var v:vector);
var t:tipo;ult:lista;
begin
  leer(t);
  while(t.codPeli<>-1)do begin
    agregarAtras(v[t.codGen],ult,t);
    leer(t);
  end;
end;
procedure mostrarVecLista(v:vector);
var L:lista;i:rango;
begin
  for i:= 1 to dimF do begin
  L:=v[i];
    while(L<>nil)do begin
      writeln('codigo:',L^.dato.codPeli,' genero:',L^.dato.codGen,' puntaje:',L^.dato.puntaje);
      L:=L^.sig
    end;
  end;
end;
{b. Una vez almacenada la información, genere un vector que guarde, para cada género, el código de película con 
mayor puntaje obtenido entre todas las críticas.}
procedure guardarPunMax(var vc:vCriticas;v:vector); //volver a hacer
var i,actual:rango;
    maxCod:integer;
    max:real;
    L:lista;
begin
  max:= -1;
  for i:= 1 to dimF do begin
    actual:=i;
    L:= v[i];
    while(L<>nil)and(actual=i)do begin
      if(L^.dato.puntaje>max)then begin
        max:=L^.dato.puntaje;
        maxCod:=L^.dato.codPeli;
      end;
      L:=L^.sig;
    end;
    vc[actual].puntaje:= max; writeln('actual puntaje',vc[actual].puntaje);
    vc[actual].codPeli:= maxCod; writeln('actual peli',vc[actual].codPeli);
  end;
end;
{c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos 
en la teoría.}
procedure ordSeleccion(var v:vCriticas);
var
  i,j,p:integer; item:tipoMax;
begin
  for i:= 1 to dimF-1 do begin
    p:=i;
    for j:= i+1 to dimF do
      if(v[j].puntaje < v[p].puntaje)then 
        p:=j;
    item:=v[p];
    v[p]:=v[i];
    v[i]:=item;
  end;
end;
{d. Luego de ordenar el vector, muestre el código de película con mayor puntaje y el código de película con 
menor puntaje.}
procedure mostrarCod(v:vCriticas);
begin
    writeln('Codigo de película con menor puntaje:',v[1].codPeli);
    writeln('Codigo de película con mayor puntaje:',v[8].codPeli);
end;
var
  v:vector;
  vc:vCriticas;
begin
  inicializarV(v);
  cargar(v);
  mostrarVecLista(v);
  guardarPunMax(vc,v);
  ordSeleccion(vc);
  mostrarCod(vc);
end.
