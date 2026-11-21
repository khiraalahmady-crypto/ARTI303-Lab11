
% Lab 9 - The Name Game

:- dynamic letter/1.

% Initial set of letters
letter(a).
letter(b).
letter(c).

% Start the game
start :-
    writeln('Hi, This is the Name Game.'),
    writeln('You can add, delete or move letters to create your name.'),
    menu.

% Display the menu
menu :-
    nl,
    writeln('Choose from the following:'),
    writeln('1- Display the current set of letters'),
    writeln('2- Add a letter'),
    writeln('3- Add a letter at the top'),
    writeln('4- Add a letter at the bottom'),
    writeln('5- Delete a letter'),
    writeln('6- Delete all letters'),
    writeln('7- Exit'),
    write('Enter your choice: '),
    read(Choice),
    ( integer(Choice) ->
        handle_choice(Choice)
    ;
        writeln('Invalid choice!'),
        menu
    ).

% Handle user choices
handle_choice(1) :-
    display_letters,
    menu.

handle_choice(2) :-
    add_letter,
    menu.

handle_choice(3) :-
    add_top,
    menu.

handle_choice(4) :-
    add_bottom,
    menu.

handle_choice(5) :-
    delete_letter,
    menu.

handle_choice(6) :-
    delete_all,
    menu.

handle_choice(7) :-
    writeln('Thank you for playing! Goodbye.').

handle_choice(_) :-
    writeln('Invalid choice! Please choose from 1 to 7.'),
    menu.

% 1- Display current letters
display_letters :-
    findall(L, letter(L), Letters),
    write('Current letters: '),
    writeln(Letters).

% Check that the input is one lowercase English letter
valid_letter(L) :-
    atom(L),
    atom_length(L, 1),
    atom_codes(L, [C]),
    C >= 97,
    C =< 122.

% 2- Add a letter using assert
add_letter :-
    write('Enter a letter: '),
    read(L),
    ( valid_letter(L) ->
        assert(letter(L)),
        writeln('Letter added successfully.')
    ;
        writeln('Please enter one lowercase English letter.')
    ).

% 3- Add a letter at the top using asserta
add_top :-
    write('Enter a letter: '),
    read(L),
    ( valid_letter(L) ->
        asserta(letter(L)),
        writeln('Letter added at the top successfully.')
    ;
        writeln('Please enter one lowercase English letter.')
    ).

% 4- Add a letter at the bottom using assertz
add_bottom :-
    write('Enter a letter: '),
    read(L),
    ( valid_letter(L) ->
        assertz(letter(L)),
        writeln('Letter added at the bottom successfully.')
    ;
        writeln('Please enter one lowercase English letter.')
    ).

% 5- Delete one letter using retract
delete_letter :-
    write('Enter the letter to delete: '),
    read(L),
    ( retract(letter(L)) ->
        writeln('Letter deleted successfully.')
    ;
        writeln('Letter not found.')
    ).

% 6- Delete all letters using retractall
delete_all :-
    retractall(letter(_)),
    writeln('All letters have been deleted.').

