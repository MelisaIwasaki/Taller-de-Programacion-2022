{1.- El administrador de un edificio de oficinas, cuenta en papel, con la información del pago de las expensas de dichas
 oficinas. 
Implementar un programa que:
	a)Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa código de 
    identificación, DNI del propietario y valor de la expensa. La lectura finaliza cuando llega el código de 
    identificación -1.
	b)Ordene el vector, aplicando uno de los métodos vistos en la cursada, para obtener el vector ordenado por código de 
    identificación de la oficina.
	c)Realice una búsqueda dicotómica que recibe el vector generado en b) y un código de identificación de oficina y 
    retorne si dicho código está en el vector. En el caso de encontrarlo, se debe informar el DNI del propietario y en 
    caso contrario informar que el código buscado no existe.
	d)Tenga un módulo recursivo que retorne el monto total de las expensas.
}
program practica1;
const
  dimF=300;
type
  rango=1..dimF;
  oficina=record
    codigo:integer;
    dni:integer;
    valor:real;
  end;
  vector=array[rango]of oficina;

procedure leerOficina(var o:oficina);
begin
    writeln('Ingrese codigo de identificacion:');
    readln(o.codigo);
    if(o.codigo<>-1)then begin
      write('DNI:');
      o.dni:=random(8);
      writeln(o.dni);
      write('valor:');
      o.valor:=random(10);
      writeln(o.valor);
    end;
end;
procedure cargarVector(var v:vector;var dimL:integer);
var i:integer; o:oficina;
begin
  leer(o);
  while(dimL<dimF)and(o.codigo<>-1)do begin 
    dimL:=dimL+1;
    v[o.codigo]:=o;
    leer(o);
  end;
end;
procedure ordenarVector(var v:vector;dimL:rango);
var i,j,pos:rango; item:oficina;
begin
  for i:=1 to dimL-1 do begin
    pos:=i;
    for j:= i+1 to dimL do
      if(v[j].codigo < v[pos].codigo)then p:=j;
    item:=v[pos];
    v[pos]:=v[i];
    v[i]:=item;
  end;
end;
procedure busDicotomica(var v:vector;var i:rango;dimL:rango;codigo:integer);
var pri,ult,medio:rango;
begin
  i:=0; pri:=1; ult:=dimL;
  medio:=(pri+ult)div 2;
  while(pri<=ult)and(codigo<>v[medio])do begin
    if(codigo<v[medio])then
      ult:=medio-1;
    else
      pri:=medio+1;
    medio:=(pri+ult)div 2;   
  end;
  if(pri<=ult)then i:=medio;
              else i:=0;
end;
function montoTotal(v:vector;total:real;i,dimL:integer):real;
begin
  i:=1;
  if(i<=dimL)then begin
    total:=total+v[i].valor;
    i:=i+1;
    montoTotal:=montoTotal(v,total,i,dimL);
  end;
end;
var 
  v:vector;
  dimL,i,pos:rango;
  codigo:integer;
  montoT,total:real;
begin
  Randomize;
  dimL:=0;
  cargarVector(v,dimL);
  ordenarVector(v,dimL);
  writeln('Ingrese codigo a buscar:');
  readln(codigo);
  busDicotomica(v,i,dimL,codigo);
  if(i=0)then
    writeln('Codigo buscado no existe');
  else
    writeln('DNI del propietario:',v[i].dni);
  montoT:=montoTotal(v,total,pos,dimL);
End.
