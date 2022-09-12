{
5.- Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el siguiente encabezado:
   	Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice); 

Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector.
}
program recursion5;

Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice); 
var medio:indice; 
begin
  pos:=0; ini:=1; fin:=dimF;
  medio:= (ini+fin)div 2;
  while(ini<=fin)and(dato<>v[medio])do begin
    if(dato<v[medio])then fin:=medio-1;
                     else ini:=medio+1;
    medio:=(ini+fin)div 2;
  end;
  if(ini<=fin)then pos:=medio;
              else pos:=-1;
end;
