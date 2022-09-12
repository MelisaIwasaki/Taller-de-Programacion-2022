{
4.- Una librería requiere el procesamiento de la información de sus productos. De cada producto se conoce el 
código del producto, código de rubro (del 1 al 8) y precio. 
Implementar un programa modularizado que:
a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una
estructura de datos adecuada. El ingreso de los productos finaliza cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que puede haber más o 
menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los primeros 
30 que están en la lista e ignore el resto. 
d. Ordene, por precio, los elementos del vector generado en b) utilizando alguno de los dos métodos vistos en la 
teoría. 
e. Muestre los precios del vector ordenado.
}

program ordenacion4;
const
  dimF=8;
type
  rango=1..dimF;
  producto=record
    codP:integer;
    codR:rango;
    precio:real;
  end;
  tipoElem=producto;
  lista=^nodo;
  nodo=record
    dato:tipoElem;
    sig:lista;
  end;
  vector=array[rango]of lista;
  vector30=array[1..30]of tipoElem;
  
procedure leer(var p:producto);
begin
  writeln('Ingrese el precio:');
  readln(p.precio);
  if(p.precio<>0)then begin
    writeln('Ingrese el codigo del producto:');
    readln(p.codP);
    writeln('Ingrese el codigo de rubro:');
    readln(p.codR);
  end;
end;
procedure insertarOrdenado(var L:lista;p:producto);
var  act,ant,nue:lista;
begin
  new(nue);
  nue^.dato:= p;
  ant:= L;
  act:= L;
  while (act <> nil)and(act^.dato.codP < p.codP)do begin
    ant:= act;
    act:= act^.sig;
  end;
  if(ant = act)then L:= nue
               else ant^.sig:= nue;
  nue^.sig:= act;
end;
procedure inicializar(var v:vector);
var i:rango;
begin
  for i:= 1 to dimF do
    v[i]:=nil;
end;
procedure cargar(var v:vector);
var p:producto;
begin
  leer(p);
  while(p.precio<>0)do begin
    insertarOrdenado(v[p.codR],p);
    leer(p);
  end;
end;
procedure mostrarVecLista(v:vector);
var L:lista;i:rango;
begin
  for i:= 1 to dimF do begin
  L:=v[i];
  writeln('Vector:',i);
    while(L<>nil)do begin
      writeln('codigo:',L^.dato.codP,' rubro:',L^.dato.codR,' precio:',L^.dato.precio);
      L:=L^.sig
    end;
  end;
end;
{c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que puede haber más
o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los 
primeros 30 que están en la lista e ignore el resto.}
procedure generarRubroTres(var vt:vector30;var dimL:integer; v:vector);
var
  L:lista;
begin
  dimL:=0;
  L:= v[3];
  while(L<>nil)and(dimL<30)do begin
    dimL:=dimL+1;
    vt[dimL]:= L^.dato;
    L:=L^.sig;
  end;
end;
{b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
d. Ordene, por precio, los elementos del vector generado en b) utilizando alguno de los dos métodos vistos 
en la teoría.
(El vector es de lista, asi que tendria que usar insertarOrdenado de lista.
Pero en el enunciado dice que use algunos metodos de la teoria?)    
}
procedure ordSeleccion(var v:vector);
var
  i,j,p:integer; item:tipoElem;
begin
  for i:= 1 to dimF-1 do begin
    p:=i;
    for j:= i+1 to dimF do
      if(v[j].precio < v[p].precio)then //main.pas(112,15) Error: Illegal qualifier
        p:=j;
    item:=v[p];
    v[p]:=v[i];
    v[i]:=item;
  end;
end;
var
  v:vector;
  vt:vector30;
  dimL:integer;
begin
  inicializar(v);
  cargar(v);
  mostrarVecLista(v);
  generarRubroTres(vt,dimL,v);
 // ordenar(v);
  mostrarVecLista(v);
end.
