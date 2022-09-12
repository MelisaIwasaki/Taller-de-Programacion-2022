{4.- Un teatro tiene funciones los 7 días de la semana. Para cada día se tiene una lista con las entradas vendidas. 
Se desea procesar la información de una semana. Se pide:
	a)Generar 7 listas con las entradas vendidas para cada día. De cada entrada se lee día (de 1 a 7), código de la obra, 
    asiento, monto. La lectura finaliza con el código de obra igual a 0. Las listas deben estar ordenadas por código de 
    obra de forma ascendente.
	b)Generar una nueva lista que totalice la cantidad de entradas vendidas por obra. Esta lista debe estar ordenada por 
    código de obra de forma ascendente.
	c)Realice un módulo recursivo que informe el contenido de la lista generada en b)
    }
program practica4;
const
  tam=7;
type
  rango=1..tam;
  entrada=record
    dia:rango;
    codigo:integer;
    asiento:integer;
    monto:real;
  end;
  guardar=record //no contiene dia
    codigo:integer;
    asiento:integer;
    monto:real;
  end;
  lista=^nodo;
  nodo=record
    dato:guardar;
    sig:lista;
  end;
  vector=array[rango]of lista;
  regAcu=record
    codigo:integer;
    cant:integer;
  end;
  listaAcu=^nodoAcu;
  nodoAcu=record
    dato:regAcu;
    sig:listaAcu;
  end;

procedure leer(var e:entrada);
begin
  with e do begin
    codigo:=random(10)+0;
    writeln('Codigo:',codigo);
    if(codigo<>0)then begin
      writeln('Ingrese el dia:');
      readln(dia);
      asiento:=random(10);
      writeln('Asiento:',asiento);
      monto:=random(10);
      writeln('Monto:',monto);
    end;
  end;
end;
procedure insertarOrdenado(var L:lista;e:entrada);
var nue,ant,act:lista;
begin
  new(nue);
  nue^.dato:=e;
  ant:=L;
  act:=L;
  while(act<>nil)and(act^.dato.codigo<e.codigo)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(ant=act)then  L:=nue;
             else  ant^.sig:=nue;
  nue^.sig:=act;
end;
procedure inicializar(var v:vector);
var i:rango;
begin
  for i:= 1 to tam do
    v[i]:=nil;
end;
procedure armarGuardar(e:entrada;var g:guardar);
begin
  g.codigo:=e.codigo;
  g.asiento:=e.asiento;
  g.monto:=e.monto;
end;
procedure cargarVectorDeLista(var v:vector);
var e:entrada; g:guardar;
begin
  inicializar(v);
  leer(e);
  while(e.codigo<>0)do begin
    armarGuardar(e,g);
    insertarOrdenado(v[e.dia], g);
    leer(e);
  end;
end;
{b)Generar una nueva lista que totalice la cantidad de entradas vendidas por obra. Esta lista debe estar ordenada por 
código de obra de forma ascendente.}
procedure insertarOrdenado(var L:lista;reg:regAcu);
var nue,ant,act:lista;
begin
  new(nue);
  nue^.dato:=reg;
  ant:=L;
  act:=L;
  while(act<>nil)and(act^.dato.codigo<reg.codigo)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(ant=act)then  L:=nue;
             else  ant^.sig:=nue;
  nue^.sig:=act;
end;
procedure minimo(var v:vector;var gmin:guardar);
var pos,i:integer;
begin
  gmin.codigo:=999;
  for i:=1 to tam do begin
    if(v[i]<>nil)then
      if(v[i]^.dato.codigo<=gmin.codigo)then begin
        pos:=i;
        gmin:=v[i]^.dato;
      end;
  end;
  if(gmin.codigo<>999)then 
    v[pos]:=v[pos]^.sig;
end;
procedure mergeAcu(v:vector:var L:listaAcu);
var  gmin:guardar;actual:regAcu;
begin  
  L:=nil;
  minimo(v,gmin);
  while(gmin.codigo<>999)do begin //corte
    actual.codigo:=gmin.codigo;
    actual.cant:=0; //inicializa
    while(actual.codigo=gmin.codigo)do begin //corte de control
      actual.cant:=actual.cant+1;
      minimo(v,gmin);
    end;
    insertarOrdenado(L,actual);
  end;
end;
{c)Realice un módulo recursivo que informe el contenido de la lista generada en b)}
procedure imprimirAcu(L:listaAcu);
  procedure mostrarListaNueva(L:listaAcu);
  begin
    if(L<>nil)then begin
      writeln(L^.dato.codigo,L^.dato.cant);
      mostrarListaNueva(L^.sig);
    end;
  end;
begin
  if(L=nil)then writeln('Sin elementos');
  else  mostrarListaNueva(L);
end;
var  
  v:vector;
  L:=listaAcu;
begin
  Randomize;
  cargarVectorDeLista(v);
  mergeAcu(v,L); 
  imprimirAcu(L);
end.
    
