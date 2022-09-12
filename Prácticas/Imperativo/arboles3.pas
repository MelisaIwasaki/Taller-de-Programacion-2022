{1.Implementar un programa que contenga:
a.Un módulo que contenga información de alumnos de Taller de Programación y almacene en una estructura de datos sólo a 
aquellos alumnos que posean año de ingreso posterior al 2010.De cada alumno se lee legajo,dni y año de ingreso.La 
estructura generada debe ser eficiente para la búsqueda por número de legajo.
b.Un módulo que reciba la estructura generada en a. e informe el dni y año de ingreso de aquellos alumnos cuyo legajo
sea inferior a un valor ingresado como prámetro.
c.Un módulo que reciba la estructura generada en a. e informe el dni, el año de ingreso de aquellos alumnos cuyo legajo
esté comprendido entre dos valores que se reciben como parámetro.
d.Un módulo que reciba la estructura generada en a. y retorne el dni más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
}
program arboles3;
type
  alumno=record
    legajo:integer;
    dni:integer;
    anioI:integer;
  end;
  arbol=^nodo;
  nodo=record
    dato:alumno;
    HI:arbol;
    HD:arbol;
  end;

procedure leer(var a:alumno);
begin
  with a do begin
    legajo:=random(10);
    dni:=random(8);
    anioI=2000+random(22);
  end;
end;
procedure crear(var a:arbol;alu:alumno);
begin
  if(a=nil)then begin
    new(a);
    a^.dato:=alu;
    a^.HI:=nil;
    a^.HD:=nil;
  end
  else if(a^.dato.legajo<alu.legajo)then  
         crear(a^.HI,alu);
       else
         crear(a^.HD,alu);
end;
procedure cargarArbol(var a:arbol);
var alu:alumno;
begin
  leer(alu);
  while(alu.anioI>2010)do begin
    crear(a,alu);
    leer(alu);
  end;
end;
{b.Un módulo que reciba la estructura generada en a. e informe el dni y año de ingreso de aquellos alumnos cuyo legajo
sea inferior a un valor ingresado como prámetro.}
procedure codicionB(a:arbol;valor:integer);
begin
  if(a<>nil)then begin
    if(a^.dato.legajo < valor)then begin
      writeln(a^.dato.dni,a^.dato.anioI);
      condicionB(a^.HI,valor);
      condicionB(a^.HD,valor);
    end;
  end;
end;
{c.Un módulo que reciba la estructura generada en a. e informe el dni, el año de ingreso de aquellos alumnos cuyo legajo
esté comprendido entre dos valores que se reciben como parámetro.}
procedure codicionC(a:arbol;valor1,valor2:integer);
begin
  if(a<>nil)then begin
    if(a^.dato.legajo >= valor1)and(a^.dato.legajo <= valor2)then begin
      writeln(a^.dato.dni,a^.dato.anioI);
      condicionB(a^.HI,valor1,valor2);
      condicionB(a^.HD,valor1,valor2);
    end;
  end;
end;
{d.Un módulo que reciba la estructura generada en a. y retorne el dni más grande.}
function maximo(a:arbol;max:integer):integer;  //max:=-1;
begin
  if(a<>nil)then begin
    if(a^.dato.dni> max)then begin
      max:=a^.dato.dni;
      maximo:=maximo(a^.HI,max);
      maximo:=maximo(a^.HD,max);
    end;
  end;
end;
{e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.}
procedure cantImpar(a:arbol;cant:integer);
begin
  if(a<>nil)then begin
    if((a^.dato.legajo mod 2)=1)then begin
      cant:=cant+1;
      cantImpar(a^.HI,cant);  //cantImpar:=cantImpar(a^.HI)+1; vale hacer??
      cantImpar(a^.HD,cant);
    end;
  end;
end;
var  
  abb:arbol;
  valor,valor1,valor2,max,cant:integer;
begin
  max:=-1;
  cargarArbol(abb);
  readln(valor);
  codicionB(a,valor);
  readln(valor1);
  readln(valor2);
  codicionC(a,valor1,valor2);
  writeln('Maximo:',maximo(abb,max));
  cantImpar(abb,cant);
End.
