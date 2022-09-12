{1.Escribir un programa que:
a.Implemente un módulo que lea información de socios de un club y las almacene en un árbol binario de búsqueda.
De cada socio se lee número de socio,nombre y edad.La lectura finaliza con el número de socio 0 y el árbol debe quedar 
ordenado por número de socio.
b.Una vez generado el árbol, realice módulos independientes que reciban el árbol como parámetros y que :
i.Informe el número de socio más grande.Debe invocar a un módulo recursivo que retorne dicho valor.
ii.Informe los datos del socio con el número de socio más chico.Debe invocar a un módulo recursivo que retorne dicho 
socio.
iii.Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
iv.Aumente en 1 la edad de todos los socios.
v.Lea un valor entero e informe si existe o no existe un socio con ese valor.Desde invocar a un módulo recursivo que 
reciba el valor leído y retorne verdadero o falso.
vi.Lea un nombre e informe si existe o no existe un socio con ese nombre.Debe invocar a un módulo reursivo que reciba 
el nombre leído y retorne verdadero o falso.
vii.Informe la cantidad de socios.Debe invocar a un módulo recursivo que retorne dicha cantidad.
viii.Informe el promedio de edad de los socios.Debe invocar a un módulo recursivo que retorne dicho promedio.
ix.Informe, a partir de dos valores que se leen, la cantidad de socios en el árbol cuyo número de socios se encuentra
entre los dos valores ingresados.Debe invocar a un módulo recursivo que reciba los dos valores leídos y retorne dicha
cantidad.
x.Informe el número de socio en orden creciente.
xi.Informe el número de socio pares en orden decreciente.
}

program arbol1;
type
  cadena=string[30];
  socio=record
    numero:integer;
    nombre:cadena;
    edad:integer;
  end;
  tipoElem=socio;

  arbol=^nodo;
  nodo=record
    dato:tipoElem;
    HI:arbol;
    HD:arbol;
  end;

procedure leerSocio(var s:socio);
begin
    with s do begin
      numero:=random(10);
      if(numero<>0)then begin 
        randomString(30,nombre);
        edad:=random(100);
      end;
    end;
end;

procedure crear(var a:arbol;tipo:tipoElem);
begin
    if(a=nil)then begin 
      new(a);
      a^.dato:=tipo;
      a^.HD:=nil;
      a^.HI:=nil;
    end
    else
        if(s.numero< a^.dato.numero)then
          crear(a^.HI,tipo);
        else
          crear(a^.HD,tipo);
end;

procedure cargarArbol(var abb:arbol);
var 
  tipo:tipoElem;
begin
    leerSocio(tipo);
    while(tipo.numero<>0)do begin     
      crear(abb,tipo);
      leerSocio(tipo);
    end;
end;

{i.Informe el número de socio más grande.Debe invocar a un módulo recursivo que retorne dicho valor.}

function maximoRec(a:arbol):integer;  
begin
    if(a^.HD<>nil)then begin
      maximoRec:= maximoRec(a^.HD);
    end
    else
      maximoRec:= a^.dato.numero;  //numero de socio??
end;

{ii.Informe los datos del socio con el número de socio más chico.Debe invocar a un módulo recursivo que retorne dicho 
socio.}
function minimoRec(a:arbol):arbol;
begin
  if(a=nil)and(a^.HI=nil)then 
      minimoRec:=a;
    else
      minimoRec:=minimoRec(a^.HI);
end;
procedure minimoSocio(a:arbol);
begin
  if(minimoRec(a) = nil)then        //preguntar si se puede hacer esto.
    writeln('El arbol esta vacio');
  else
    writeln('Nuumero: ',a^.dato.numero,' nombre: ',a^.dato.nombre,' edad: ',a^.dato.edad);
end;

{iii.Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.}
procedure maximoSocio(a:arbol;var  maxEdad:integer;var maxSocio:integer);

	procedure maximo(edad,numero:integer;var maxEdad1,maxEdad2,maxSocio1,maxSocio2:integer);
	begin
		if(edad>maxEdad1)then begin
		  maxEdad2:=maxEdad1;
		  maxEdad1:= edad;
		  maxSocio2:=maxSocio1;
		  maxSocio1:= numero;
		end
		else if(edad>maxEdad2)then begin
		  maxEdad2:=edad;
		  maxSocio2:=numero;
		end;
	end;
begin
	if(a=nil)then
	  maxEdad:= -1;
	else begin
	  maximoSocio(a^.HI, maxEdad1,maxSocio1);
	  maximoSocio(a^.HD, maxEdad2,maxSocio2);
	  maximo(a^.dato.edad, a^.dato.numero,maxEdad1,maxEdad2,maxSocio1,maxsocio2);
	end;
end;

{iv.Aumente en 1 la edad de todos los socios.}
procedure aumentarEdad(a:arbol);
begin
	if(a<>nil) then begin 
	  a^.dato.edad:=a^.dato.edad+1;
	  aumentarEdad(a^.HI);
	  aumentarEdad(a^.HD);
	end;
end;
{v.Lea un valor entero e informe si existe o no existe un socio con ese valor.Desde invocar a un módulo recursivo que 
reciba el valor leído y retorne verdadero o falso.}
procedure buscar(a:arbol;numero:integer):boolean;
begin
	if(a=nil)then buscar:=false;
	else if(a^.dato.numero=num)then
	       buscar:=true;
	     else if(num<a^.dato.numero)then
	       buscar:=buscar(a^.HI,num);
	     else
	       buscar:=buscar(a^.HD,num);
	         
end;

{vi.Lea un nombre e informe si existe o no existe un socio con ese nombre.Debe invocar a un módulo reursivo que reciba 
el nombre leído y retorne verdadero o falso.}
procedure buscar(a:arbol;nombre:integer):boolean;
begin
	if(a=nil)then buscar:=false;
	else if(a^.dato.nombre=nombre)then
	     then buscar:=true;
	     else if(nombre<a^.dato.nombre)then
	       buscar:=buscar(a^.HI,num);
	     else
	       buscar:=buscar(a^.HD,num);
	         
end;
{vii.Informe la cantidad de socios.Debe invocar a un módulo recursivo que retorne dicha cantidad.}
function cantidad(a:arbol):integer;
begin
  if(a<>nil)then begin
    cant:=cant+1;
    cantidad(a^.HI,cant);
    cantidad(a^.HD,cant);
  end;
end;
{viii.Informe el promedio de edad de los socios.Debe invocar a un módulo recursivo que retorne dicho promedio.}
procedure promedio(a:arbol;cant:integer;var edad:integer);
begin
  cant:=cantidad(a);
  if(a<>nil)then begin
    edad:=edad+a^.dato.edad;
    promedio:=promedio(a^.HI,cant,edad);    //Preguntar
    promedio:=promedio(a^.HD,cant,edad);
  end;
end;
{ix.Informe, a partir de dos valores que se leen, la cantidad de socios en el árbol cuyo número de socios se encuentra
entre los dos valores ingresados.Debe invocar a un módulo recursivo que reciba los dos valores leídos y retorne dicha
cantidad.}
procedure entreDosValores(a:arbol;valor1,valor2:integer;var cant:integer);
begin
  if(a<>nil)then begin
    if(a^.dato.numero>=valor1)and(a^.dato.numero<=valor2)then begin
      cant:=cant+1;
      entreDosValores(a^.HI,valor1,valor2,cant);
      entreDosValores(a^.HD,valor1,valor2,cant);
    end;
  end;
end;
{x.Informe el número de socio en orden creciente.} 
procedure ordenCreciente(a:arbol);
begin
  if(a<>nil)then begin 
    ordenCreciente(a^.HI);
    writeln(a^.dato, '|');
    ordenCreciente(a^.HD);
  end;
end;
{xi.Informe el número de socio pares en orden decreciente.}
procedure ordenDecreciente(a:arbol);
begin
  if(a<>nil)then begin
    ordenDecreciente(a^.HD);
    if((a^.dato mod 2 )= 0)then
      writeln(a^.dato,'|');
    ordenDecreciente(a^.HI);
end;

var
  abb:arbol;
  maxEdad,maxSocio:integer;
  num,cant:integer;
  ok:boolean;
  nombre:cadena;
begin
  Randomize;
  abb:=nil;
  cargarArbol(abb);
  if(maximoRec(abb)<>nil)then
    writeln('Numero maximo:',maximoRec(abb)^.dato);
  else
    writeln('Numero maximo: 0');
  minimoSocio(a);
  maximoSocio(a,maxEdad,maxSocio);
  aumentarEdad(a);
  writeln('Ingrese el numero de socio a buscar:');
  ok:=buscar(a,num);
  if(ok)then writeln('SE encontro el numero');
  writeln('Ingrese el nombre a buscar:');
  ok:=buscar(a,nombre);
  if(ok)then writeln('SE encontro el nombre');
  cant:=cantidad(a);
  writeln('La cantidad de socios:',cant);
  readln(valor1);
  readln(valor2);
  entreDosValores(a,valor1,valor2,cant);
  writeln('Cantidad socios en condicion:',cant);
  ordenCreciente(a);
  ordenDecreciente(a);  
end;
    
