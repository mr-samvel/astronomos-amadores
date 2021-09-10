% Resolução do problema de lógica normal "Astrônomos Amadores"
% Disponível em: https://rachacuca.com.br/logica/problemas/astronomos-amadores/

%%%%%%%%%%%%%%%%%%%%%%%%%
% "Base de dados"

camisa(amarela).
camisa(azul).
camisa(verde).
camisa(branca).
camisa(vermelha).

nome(alan).
nome(cleber).
nome(luis).
nome(milton).
nome(vinicius).

idade(27).
idade(29).
idade(32).
idade(33).
idade(35).

constelacao(andromeda).
constelacao(aries).
constelacao(escorpiao).
constelacao(orion).
constelacao(pegasus).

altura(166).
altura(170).
altura(172).
altura(175).
altura(181).

esporte(basquete).
esporte(futebol).
esporte(natacao).
esporte(volei).
esporte(sinuca).
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
% Regras

% X esta exatamente à esquerda de Y
precede(X, Y, Lista) :- nextto(X, Y, Lista).

% X esta na ponta se é o primeiro ou último da lista.
na_ponta(X, [X|_]).
na_ponta(X, Lista) :- last(Lista, X).

% X está em qualquer posicao entre YEsq (à esquerda) e YDir (à direita).
entre(X, YEsq, YDir, Lista) :- a_direita(X, YEsq, Lista), a_esquerda(X, YDir, Lista).

% X está em qualquer posição à esquerda de Y.
a_esquerda(X, Y, Lista) :- nth0(IndexX, Lista, X), nth0(IndexY, Lista, Y), IndexX < IndexY.

% X está em qualquer posição à direita de Y.
a_direita(X, Y, Lista) :- a_esquerda(Y, X, Lista).

% X está ao lado de Y
ao_lado(X, Y, Lista) :- nextto(X, Y, Lista) ; nextto(Y, X, Lista).

% Todos os elementos da lista são unicos
todos_diferentes([]).
todos_diferentes([H|T]) :- not(member(H,T)), todos_diferentes(T).
%%%%%%%%%%%%%%%%%%%%%%%%%

solucao(Astronomos) :-
    Astronomos = [
        (Camisa1, Nome1, Idade1, Constelacao1, Altura1, Esporte1),
        (Camisa2, Nome2, Idade2, Constelacao2, Altura2, Esporte2),
        (Camisa3, Nome3, Idade3, Constelacao3, Altura3, Esporte3),
        (Camisa4, Nome4, Idade4, Constelacao4, Altura4, Esporte4),
        (Camisa5, Nome5, Idade5, Constelacao5, Altura5, Esporte5)
    ],
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % Dicas/Regras específicas

    % Na segunda posição está o astrônomo com a camisa Vermelha.
    Camisa2 = vermelha,
    % O homem de 29 anos está em uma das pontas.
    na_ponta((_,_,29,_,_,_), Astronomos),
    % O astrônomo de Vermelho está em algum lugar entre quem gosta de Natação e quem tem 35 anos, nessa ordem.
    entre((vermelha,_,_,_,_,_), (_,_,_,_,_,natacao), (_,_,35,_,_,_), Astronomos),
    % O astrônomo de 32 anos gosta de jogar Basquete.
    member((_,_,32,_,_,basquete), Astronomos),
    % Quem gosta de Vôlei está ao lado de quem tem 1,66 m de altura.
    ao_lado((_,_,_,_,_,volei), (_,_,_,_,166,_), Astronomos),
    % Milton está em algum lugar à direita de quem está de Branco.
    a_direita((_,milton,_,_,_,_), (branca,_,_,_,_,_), Astronomos),
    % O astrônomo de 1,70 m está observando a constelação de Andrômeda.
    member((_,_,_,andromeda,170,_), Astronomos),
    % Os astrônomos que gostam de Futebol e Basquete estão lado a lado.
    ao_lado((_,_,_,_,_,futebol), (_,_,_,_,_,basquete), Astronomos),
    % Quem está observando a constelação de Pegasus está em algum lugar entre Cleber e o homem de Branco, nessa ordem.
    entre((_,_,_,pegasus,_,_), (_,cleber,_,_,_,_), (branca,_,_,_,_,_), Astronomos),
    % Luís está usando uma camisa Branca.
    member((branca,luis,_,_,_,_), Astronomos),
    % O homem que gosta de Natação está exatamente à esquerda de quem tem 27 anos.
    precede((_,_,_,_,_,natacao), (_,_,27,_,_,_), Astronomos),
    % O astrônomo de 1,81 m gosta de jogar Vôlei.
    member((_,_,_,_,181,volei), Astronomos),
    % Alan está em uma das pontas.
    na_ponta((_,alan,_,_,_,_), Astronomos),
    % O astrônomo que está observando a constelação de Escorpião está ao lado do astrônomo de 1,72 m.
    ao_lado((_,_,_,escorpiao,_,_), (_,_,_,_,172,_), Astronomos),
    % O astrônomo de Amarelo está observando Orion.
    member((amarela,_,_,orion,_,_), Astronomos),
    % O homem de 1,70 m está exatamente à direita do astrônomo de 29 anos.
    precede((_,_,29,_,_,_), (_,_,_,_,170,_), Astronomos),
    % Cleber gosta de jogar Futebol.
    member((_,cleber,_,_,_,futebol), Astronomos),
    % Na quinta posição está quem gosta de jogar Sinuca.
    Esporte5 = sinuca,
    % O astrônomo de 33 anos é o mais baixo.
    member((_,_,33,_,166,_), Astronomos),
    % O astrônomo de Verde está em algum lugar entre quem tem 29 anos e quem observa a constelação de Escorpião, nessa ordem.
    entre((verde,_,_,_,_,_), (_,_,29,_,_,_), (_,_,_,escorpiao,_,_), Astronomos),
    % O homem de 1,66 m está observando a constelação de Aries.
    member((_,_,_,aries,166,_), Astronomos),
    %%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%
    % Teste/definição das propriedades
    
    camisa(Camisa1), camisa(Camisa2), camisa(Camisa3), camisa(Camisa4), camisa(Camisa5), 
    todos_diferentes([Camisa1,Camisa2,Camisa3,Camisa4,Camisa5]),

    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5), 
    todos_diferentes([Nome1,Nome2,Nome3,Nome4,Nome5]),

    idade(Idade1), idade(Idade2), idade(Idade3), idade(Idade4), idade(Idade5), 
    todos_diferentes([Idade1,Idade2,Idade3,Idade4,Idade5]),

    constelacao(Constelacao1), constelacao(Constelacao2), constelacao(Constelacao3), constelacao(Constelacao4), constelacao(Constelacao5), 
    todos_diferentes([Constelacao1,Constelacao2,Constelacao3,Constelacao4,Constelacao5]),

    altura(Altura1), altura(Altura2), altura(Altura3), altura(Altura4), altura(Altura5), 
    todos_diferentes([Altura1,Altura2,Altura3,Altura4,Altura5]),

    esporte(Esporte1), esporte(Esporte2), esporte(Esporte3), esporte(Esporte4), esporte(Esporte5),
    todos_diferentes([Esporte1,Esporte2,Esporte3,Esporte4,Esporte5]).
    %%%%%%%%%%%%%%%%%%%%%%%%%


imprime([A|As]) :- 
    write(A), nl,
    imprime(As).

main :-
    solucao(Astronomos),
    imprime(Astronomos).