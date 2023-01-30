init:-
    csv_read_file("/Users/aastha/Desktop/AI-A2-Aastha-2019224/Distance.csv", Rows,[functor(cities_distances)]),
    maplist(assert,Rows),
    csv_read_file("/Users/aastha/Desktop/AI-A2-Aastha-2019224/Heuristic.csv", Rows2,[functor(table)]),
    maplist(assert,Rows2),
    expects_dialect(sicstus4),

    write("--------------------------Welcome to Search Road Route Program!---------------"),nl,nl,
    write("This program searches a road route from source city to destination city using Depth First or Best First Search."),nl,nl,
    input_source(Source),
    input_destination(Destination),
    input_option(Option),
    (Option==dfs -> dfs_init(Source,Destination); bfs_init(Source,Destination)).

input_source(Source):-
    write("Please enter the source:"),nl,
    read(Source).

input_destination(Destination):-
    write("Please enter the destination:"),nl,
    read(Destination).

input_option(Option):-
    write("Please choose an option- (dfs,bfs) "),nl,
    read(Option).

get_distance(Source,Dest,Weight):-
    cities_distances(Source,Dest,Weight).

get_distance(Source,Dest,Weight):-
    cities_distances(Dest,Source,Weight).

sum_cost(X,Y,Z):-
    Z is X + Y.

city_not_visited(Node,Visited):-
    nonmember(Node,Visited).
    
bfs_init(Source,Destination):-
    nl,write("--------------------------------BFS Path---------------------------------------"),nl,
    write(Source),
    bfs([Source],0,Source,Destination).

dfs_init(Source,Destination):-
    nl,write("--------------------------------DFS Path---------------------------------------"),nl,nl,
    write(Source),
    dfs([Source],0,Source,Destination).

bfs(_,Cost,Goal,Goal):-
    nl,nl,
    write("---------------------------------Cost---------------------------------------------"),nl,
    write(Cost).

bfs(Visited,CurrentCost,Current,Goal):-
    aggregate(min(L,Next), table(Current,Next,L),min(PathLength,Next)),
    city_not_visited(Next,Visited),

    sum_cost(CurrentCost,PathLength,Cost),
    write(" --> "),
    write(Next),
    bfs([Next|Visited],Cost,Next,Goal).

dfs(_,Cost,Goal,Goal):-
    nl,nl,
    write("---------------------------------Cost--------------------------------------------"),nl,
    write(Cost).

dfs(Visited,CurrentCost,Current,Goal):-
    get_distance(Current,Next,PathLength),
    city_not_visited(Next,Visited),

    sum_cost(CurrentCost,PathLength,Cost),
    write(" --> "),
    write(Next),
    dfs([Next|Visited],Cost,Next,Goal).

    