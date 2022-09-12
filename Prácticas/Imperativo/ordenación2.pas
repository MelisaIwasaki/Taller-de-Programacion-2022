{
2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de 
dichas oficinas. 
Implementar un programa modularizado que:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el 
código de identificación, DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el 
código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}


program ordenacion2;
const
  dimF=300;
type
  rango=1..dimF;
  oficina=record
    codigo:integer;
    dni:integer;
    valor:real;
  end;
  tipo=oficina;
  vector=array[rango]of tipo;
  
procedure leer(var o:oficina);
begin
  writeln('Ingrese codigo:');
  readln(o.codigo);
  if(o.codigo<>-1)then begin
    writeln('Ingrese dni:');
    readln(o.dni);
    writeln('Ingrese valor:');
    readln(o.valor);
  end;
end;
procedure cargar(var v:vector;var dimL:integer);
var o:oficina;
begin
  dimL:=0;
  leer(o);
  while(o.codigo<>-1)and(dimL<dimF)do begin
    v[o.codigo]:=o;
    dimL:=dimL+1;
    leer(o);
  end;
end;
procedure ordInsercion(var v:vector;dimL:integer);
var
  i,j.p:integer;actual:tipo;
begin
  for i:= 1 to dimL do begin
    actual:=v[i];
    j:=i-1;
    while(j>0)and(v[j]>actual)do begin
      v[j+1]:=v[j];
      j:=j-1;
    end;
    v[j+1]:=actual;
  end;
end;
procedure ordSeleccion(var v:vector;dimL:integer);
var
  i,j,p:integer; item:tipo;
begin
  for i:= 1 to dimL-1 do begin
    p:=i;
    for j:= i+1 to dimL do
      if(v[j]<v[p])then 
        p:=j;
    item:=v[p];
    v[p]:=v[i];
    v[i]:=item;
  end;
end;
var
  v:vector;
  dimL:integer;
begin
  cargar(v,dimL);
  ordInsercion(v,dimL);
  ordSeleccion(v,dimL);
end.
