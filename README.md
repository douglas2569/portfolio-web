# Portfólio
### Objetivo:
Estagiar como desenvolvedor web front-end, back-end ou full stack. 

### Falando um pouco sobre mim, minhas experiências e habilidades como desenvolvedor web.
```  
https://youtu.be/anql8D29g6k
```  
### Link do App Web Achaí (Nota: por ser uma hospedagem gratuita, em alguns momentos, o app pode ficar fora do ar).
```  
https://achai3.000webhostapp.com
```  
### Informações de contato. 
 E-mail: douglas2570@gmail.com
 
## Sobre
Olá, sou o Douglas, estou cursando Sistemas e Mídias Digitais na Universidade Federal do Ceará, 4° semestre, mas desde 2021 que estudo Desenvolvimento de Sistemas WEB. Por conta disso, consegui desenvolver uma lógica de programação consistente, o que me deixou confortável para, recentemente, começar a estudar alguns frameworks (Bootstrap, Angular JS e Express JS). Ademais, meu nível de inglês técnico é básico para intermediário (leitura), o que me ajudar quando preciso consultar documentações, sites ou comunidades de programação, seja para estudo ou resolução de Bugs. 

Atualmente, estou atuando como Full Stack em uma equipe composta por 6 pessoas (5 Designers UI/UX) no desenvolvimento de um aplicativo web para a universidade na qual estudo. As tecnologias que estão sendo usadas são HTML5, CSS3, JavaScript, PHP OO e MySQL. Além disso, a arquitetura de software que está sendo utilizada é a MVC. Essa estrutura foi escolhida porque, além de facilitar a manutenção do código, ela facilita o trabalho com API REST, visto que o padrão de projeto MVC separa a parte do sistema que se comunica com o usuário da parte que manipula o banco de dados.
 
### linkedin:
```  
https://www.linkedin.com/in/carlos-douglas-79746927a/
```  
## Projeto Achaí (em desenvolvimento)
 
Este projeto tem por objetivo digitalizar o serviço de Achados e perdidos do Bloco UFC Virtual, trazendo mais praticidade tanto para o utilizador final quanto para a secretaria do bloco que administra o serviço.  

## Instalação e Manutenção    

Para rodar o projeto é necessário ter em sua maquina um servidor web (o php instalado nele) e o banco de dados MySQL, tudo isso pode ser usado através do software [XAMPP] (https://www.apachefriends.org/), bastando instalá-lo e configurá-lo em sua maquina. Alem disso, se faz necessário a instalação do software [Composer] (https://getcomposer.org) para a instalação de dependências no projeto. 

### Instalação
1. Instale o executável do xampp e do composer (Só nexts padrão)
2. Clonar o projeto do Github (pode ser feito através do Github Desktop ou do comando `git clone [url]`) ou baixando o zip
3. Crie a pasta 'achai, coloque os arquivos baixados dentro,  e cole dentro do diretório htdocs do xammp (C:\xampp\htdocs)
4. Inicie o xampp e ative o servidor Apache e o banco MySQL.
5. No servidor Apache click no botão 'config' -> PHP (php.in). Nesse arquivo habilite as extensões gd (extension=gd) e zip (extension=zip)  | IMPORTANTE: reinicie o servidor apache após essas alterações.
6. Com um terminal na pasta 'achai/api/' do projeto que foi clonado, instalar as dependências através do comando:
```  
composer install  
``` 
7. Por fim, através do phpmyadmin crie um banco de dados chamado 'achai' e importe o arquivo sql que se encontra na pasta 'db'
   
## Estrutura do Projeto

No diretório raiz do projeto, podemos encontrar as seguintes pastas:

### `/api`

A pasta `/api` é onde se encontra o back-end do sistema.

### `/assets`

A pasta `/assets` é onde se encontra as imagens, folhas de estilos e scripts que serão usado em todo sistema.

### `/db`

A pasta `/db` é onde se encontra o arquivo sql com a estrutura do banco.

### `/src`

A pasta `/src` é onde se encontra o front-end.

## Esse projeto está sendo desenvolvido por alunos da UFC do curso SMD. Participantes:

### Programador (back-end/front-end)
- Carlos Douglas

### Designers (UI/UX)
- Angelo Vinicius 
- Arthur Oliveira
- Ednara Miranda
- Guilherme Ferreira
- Hebert Klei
