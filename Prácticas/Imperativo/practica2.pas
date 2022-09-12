{2.- Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la información de los autos 
en venta.
Implementar un programa que:
	a)Genere un árbol binario de búsqueda ordenado por patente identificatoria del auto en venta. Cada nodo del árbol 
    debe contener patente, año de fabricación (2010..2018), la marca y el modelo.
	b)Invoque a un módulo que reciba el árbol generado en a) y una marca y retorne la cantidad de autos de dicha marca 
    que posee la agencia. Mostrar el resultado. 
	c)Invoque a un módulo que reciba el árbol generado en a) y retorne una estructura con la información de los autos 
    agrupados por año de fabricación.
	d)Contenga un módulo que reciba el árbol generado en a) y una patente y devuelva el año de fabricación del auto con 
    dicha patente. Mostrar el resultado.
 }
program practica2;
type
  rangoF=2010..2018;
  autos=record
    patente:string;
    anio:rangoF;
    marca:string;
    modelo:string;
  end;
  arbol=^nodo;
  nodo=record
    dato:autos;
    HI:arbol;
    HD:arbol;
  end;
  lista=^nodo3;
  nodo3=record
    dato:autos;
    sig:lista;
  end;
  vector=array[rangoF]of lista;

procedure randomString(tam:integer;var word:string);
var str,result:string;
begin
  str:='abc..XYZ';
  result:=' ';
  repeat
    result:=result+str[random(Length(str))+1];
  until (Length(result)=tam);
  word:=result;
end;
procedure leer(var a:autos); //No olvidar Randomize;
begin
  with a do begin
    randomString(10,patente);
    anio:=2010+random(8)+0;  //2010 a 2018, 0 para el corte
    randomString(10,marca);
    randomString(10,modelo);
  end;
end;
procedure crear(var a:arbol;auto:autos);
begin
  if(a=nil)then begin
    new(a);
    a^.dato:= auto;
    a^.HI:=nil;
    a^.HD:=nil;
  end
  else 
    if(auto < a^.dato)then
      crear(a^.HI,auto);
    else
      crear(a^.HD,auto);
end;
procedure cargarArbol(var a:arbol);
var auto:autos;
begin
  leer(auto);
  while(auto.anio<>0)do begin
    crear(a,auto);
    leer(auto);
  end;
end;
{b)Invoque a un módulo que reciba el árbol generado en a) y una marca y retorne la cantidad de autos de dicha marca 
   que posee la agencia. Mostrar el resultado. }
procedure cantidad(a:arbol;marca:string;var cant:integer);
begin
  if(a=nil)then cant:=0;
  else if(marca=a^.dato.marca)then begin
         cant:=cant+1;
         cantidad(a^.HI,marca,cant);
         cantidad(a^.HD,marca,cant);
  end;              
end;
procedure mostrarEnOrden(a:arbol);
begin
  if(a<>nil)then begin
    mostrarEnOrden(a^.HI);
    write(a^.dato,'|');
    mostrarEnOrden(a^.HD);
  end;
end;
{c)Invoque a un módulo que reciba el árbol generado en a) y retorne una estructura con la información de los autos 
    agrupados por año de fabricación.}
procedure inicializar(var v:vector);
var i:rango;
begin
  for i:= 2010 to 2018 do
    v[i]:=nil; 
end;
procedure agregarAdelante(var L:lista; a:autos);
var nue:lista;
begin
  new(nue);
  nue^.dato:=a;
  nue^.sig:=L;
  L:=nue;
end;
procedure Agrupados(a:arbol;var v:vector);
begin
  if(a<>nil)then begin
    agregarAdelante(v[a^.dato.anio],a^.dato);
    Agrupados(a^.HI,v);
    Agrupados(a^.HD,v);
  end;
end;
{d)Contenga un módulo que reciba el árbol generado en a) y una patente y devuelva el año de fabricación del auto con 
    dicha patente. Mostrar el resultado.} //contenga:envuelva,guarde,encierre
function contener(a:arbol;patente:string):rango;
begin
  if(a<>nil)then begin
    if(a^.dato.patente=patente)then
      contener:=a^.dato.anio;
    else
      contener:=contener(a^.HI,patente);
      contener:=contener(a^.HD,patente);
end;      
var
  abb:arbol;
  marca:string;
  cant:integer;
  v:vector;
begin 
  Randomize;
  inicializar(v);  
  cargarArbol(abb);
  writeln('Ingrese la marca:'); 
  readln(marca);
  cantidad(abb,marca,cant);
  mostrarEnOrden(abb);
  Agrupados(abb,v);
  writeln('Ingrese el patente:');
  readln(patente);
  writeln('Anio:',contener(abb,patente)); 
end.
