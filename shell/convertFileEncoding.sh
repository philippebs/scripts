#!/bin/bash

backup="_bkp"

echo "Buscando arquivos $(date)"
lista_entidade=$(grep -Rl .<type-file> <path>)

total=0
for arquivo in $lista_entidade; do
	total=$(($total+1))
done

echo "" > arquivos_convertidos.log

contador=0
for entidade in $lista_entidade; do
	path=$(realpath $entidade)$backup

	echo "Original: $(file -i $entidade)" >> arquivos_convertidos.log
	iconv.exe -f iso-8859-1 -t utf-8 $entidade > $path

	# Para mostrar na tela e enviar para o arquivo com o tee
	#echo "Original: $(file -i $file)\n" | tee -a arquivos_convertidos.log
	#echo -e "Backup  : $(file -i $path)\n" | tee -a arquivos_convertidos.log
	
	$(mv $path $entidade && rm -f $path)
	echo -e "Convertido  : $(file -i $entidade)\n" >> arquivos_convertidos.log
	contador=$(($contador+1))
	porcentagem=$(($contador*100/$total))
	printf "\rConvertendo arquivos para utf-8 $porcentagem%%"
done
echo -e "\nFim da conversão dos arquivos $(date)"