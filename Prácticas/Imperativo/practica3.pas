{3.- Un supermercado requiere el procesamiento de sus productos. De cada producto se conoce código, rubro (1..10), stock
 y precio unitario. Se pide:
	a)Generar una estructura adecuada que permita agrupar los productos por rubro. A su vez, para cada rubro, se requiere 
    que la búsqueda de un producto por código sea lo más eficiente posible. La lectura finaliza con el código de producto 
    igual a -1..
	b)Implementar un módulo que reciba la estructura generada en a), un rubro y un código de producto y retorne si dicho 
    código existe o no para ese rubro.
	c)Implementar un módulo que reciba la estructura generada en a), y retorne, para cada rubro, el código y stock del 
    producto con mayor código.
	d)Implementar un módulo que reciba la estructura generada en a), dos códigos y retorne, para cada rubro, la cantidad 
    de productos con códigos entre los dos valores ingresados.
}
program practica3;
const
  tam=10;
type
  rango=1..tam;
  producto=record
    codigo:integer;
    rubro:rango;
    stock:integer;
    precio:real;
  end;
  lista=^nodo;
  nodo=record
    dato:producto;
    sig:lista;
  end;
  vector=array[rango]of lista;

procedure leer(var p:producto);
begin
  with p do begin
    writeln('Ingrese el codigo:');
    readln(codigo);
    if(codigo<>-1)then begin
      rubro:=random(10);
      stock:=random(100)+100;
      precio:=random(50)+1;
    end;
  end;
end;
procedure insertarOrdenado(var L:lista;p:producto);
var nue, ant, act:lista;
begin
  new(nue);
  nue^.dato:=p;
  ant:=L;
  act:=L;
  while(act<>nil)and(act^.dato.codigo<p.codigo)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(ant=act)then L:=nue;
             else ant^.sig:=nue;
  nue^.sig:=act;
end;
procedure inicializar(var v:vector);
var i:rango;
begin
  for i:= 1 to tam do
    v[i]:=nil;
end;
procedure cargarAgrupado(var v:vector);
var p:producto;
begin
  inicializar(v);
  leer(p);
  while(p.codigo<>-1)do begin
    insertarOrdenado(v[p.rubro],p);
    leer(p);
  end;
end;
{b)Implementar un módulo que reciba la estructura generada en a), un rubro y un código de producto y retorne si dicho 
    código existe o no para ese rubro.}
function buscar(v:vector;rubro,codigo:integer):boolean;
begin
  if(v[rubro]=nil)then buscar:=false;
  else
    if(v[rubro]^.dato.codigo=codigo)then buscar:=true;
    else
      buscar:=buscar(v[rubro]^.sig,rubro,codigo);
end;
{c)Implementar un módulo que reciba la estructura generada en a), y retorne, para cada rubro, el código y stock del 
    producto con mayor código.}
procedure maximo(v:vector;var max:integer;var maxStock:integer;i:integer);
begin
  if(v[i]<>nil)then begin
    if(v[i]^.dato.codigo>max)then begin
      max:=v[i]^.dato.codigo;
      maxStock:=v[i]^.dato.stock;
    end;
    maximo(v[i]^.sig,max,maxStock,i);
end;
procedure cadaRubroMax(v:vector);
var max,maxStock:integer;
begin
  i:=1;
  while(i<tam)do begin 
    maximo(v,max,maxStock,i);
    writeln('Producto con mayor codigo:');
    writeln('Rubro:',i,' codigo:',max,' stock:',maxStock);
    i:=i+1;
  end;
end;
{d)Implementar un módulo que reciba la estructura generada en a), dos códigos y retorne, para cada rubro, la cantidad 
    de productos con códigos entre los dos valores ingresados.}
procedure entreDosValores(v:vector;codigo1,codigo2:integer;var cantidad:integer;i:integer);
begin
  if(v[i]<>nil)then begin
    if(v[i]^.dato.codigo >= codigo1)and(v[i]^.dato.codigo <= codigo2)then begin
      cantidad:=cantidad+1;
      entreDosValores(v[i]^.sig,codigo1,codigo2,cantidad,i);
    end;
  end;
end;
procedure cadaRubroCant(v:vector);
var  codigo1,codigo2,cantidad:integer;
begin
  i:=1;
  cantidad:=0;
  writeln('Ingrese un valor:');
  readln(codigo1);
  writeln('Ingrese otro valor:');
  readln(codigo2);
  while(i<tam)do begin
    entreDosValores(v,codigo1,codigo2,cantidad,i);
    writeln('Rubro:',i);
    writeln('Cantidad de productos:',cantidad);
    i:=i+1;
  end;
end;
var
  v:vector;
  rubro,codigo:integer;
  ok:boolean;
begin
  Randomize;
  cargarAgrupado(v);
  writeln('Ingrese el rubro y el codigo a buscar:');
  readln(rubro);
  readln(codigo);
  ok:=buscar(v,rubro,codigo);
  if(ok)then writeln('Se econtro el codigo');
  cadaRubroMax(v);
  cadaRubroCant(v);
END.
