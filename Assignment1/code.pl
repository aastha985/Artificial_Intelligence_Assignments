/*Knowledge Base*/

/* Electives with field, semester and prerequisites */
elective(cse, monsoon,
    d{
        computer_networks:[ip,os,ada],
        foundations_of_computer_security:[],
        network_security: [],
        modern_algorithm_design: [],
        information_integration_and_applications: [],
        computer_graphics: [],
        compilers:[]
    }).

elective(cse,winter,
    d{
        theory_of_computation: [m3],
        network_and_system_security_2: [os,cn],
        foundations_of_parallel_programming: [ip,dsa,ap],
        concurrent_and_learned_datastructures: [ip,dsa,ap,os],
        mobile_computing: [ip],
        wireless_network: [cn],
        decision_procedures: [dsa,ap,m3],
        semantic_web: [ip,dbms]
    }).

elective(csai, monsoon,
    d{
        digital_image_processing:[m1,m2],
        artificial_intellgience: [dsa],
        machine_learning: [m1,m2,ip,m3],
        natural_language_processing: [ip,m2,ada,m1],
        advanced_machine_learning: [m2,ml],
        data_mining: [dbms,ip,m1,m2]
    }).

elective(csai,winter,
    d{
        statistical_machine_learning: [ip,m2],
        machine_learning: [m1,m2,ip,m3],
        computer_vision: [m1],
        deep_learning: []
    }).

elective(design,monsoon,
    d{
        digital_audio_and_video_production_workflow:[],
        introduction_to_animation_and_graphics: [],
        animation_filmmaking_3d: [],
        design_futures: [dis]
    }).

elective(design,winter,
    d{
        design_of_interactive_systems: [],
        introduction_to_2d_animation: [],
        advanced_topics_in_human_centered_computing: [hcd],
        game_design_and_development:[]
    }).

elective(maths,monsoon,
    d{
        number_theory:[],
        scientific_computing: [m1],
        stochastic_processes_and_applications: [m2],
        complex_analysis: [ra]
    }).

elective(maths,winter,
    d{
        introduction_to_mathematical_logic: [],
        graph_theory: [],
        statistical_inference: [m2],
        linear_optimization: [m1],
        advanced_linear_algebra: [m1]
    }).

elective(ssh,monsoon,
    d{
        neuroscience_of_decision_making: [],
        urban_space_and_political_power: [],
        gender_and_media: [],
        foundations_of_finance: [],
        microeconomics: []
    }).

elective(ssh,winter,
    d{
        coginitive_psychology: [],
        social_psychology: [],
        learning_and_memory: [],
        ethics_in_ai: []
    }).

/* Easy Medium Electives, Courses not listed here belong to hard category 
   2 and 3 level electives are classified as easy-medium,  5-6 level courses as hard */
easyMedium(computer_networks).
easyMedium(foundations_of_computer_security).
easyMedium(network_security).
easyMedium(modern_algorithm_design).
easyMedium(computer_graphics).
easyMedium(compilers).
easyMedium(digital_image_processing).
easyMedium(machine_learning).
easyMedium(natural_language_processing).
easyMedium(theory_of_computation).
easyMedium(computer_vision).
easyMedium(network_and_system_security_2).
easyMedium(computer_vision).
easyMedium(statistical_machine_learning).

easyMedium(introduction_to_animation_and_graphics).
easyMedium(animation_filmmaking_3d).
easyMedium(design_of_interactive_systems).

easyMedium(number_theory).
easyMedium(scientific_computing).
easyMedium(stochastic_processes_and_applications).
easyMedium(introduction_to_mathematical_logic).
easyMedium(graph_theory).
easyMedium(statistical_inference).
easyMedium(linear_optimization).

easyMedium(neuroscience_of_decision_making).
easyMedium(foundations_of_finance).
easyMedium(coginitive_psychology).
easyMedium(learning_and_memory).

main:-  
    write("-----------------------------Welcome to Electives Advisory System!--------------------------------"),nl,nl,
    write("We advise the most suitable electives for you. Please begin by answering some simple questions."),nl,nl,nl,
    input_semester(Semester),
    input_career(Career),
    suggest_courses(Career,Semester).

input_semester(Semester):-
    write("Please choose the semester- (monsoon/winter) "),nl,
    read(Semester).

input_career(Career):- 
    nl,nl,
    write("Which one of the following Career options are you most interested in?"),nl,nl,
    write("1. Software Engineering(cse)"),nl,
    write("2. Machine Learning/Artificial Intelligence(csai)"),nl,
    write("3. Design(design)"),nl,
    write("4. Applied Mathematics(maths)"),nl,
    write("5. Not tech role(ssh)"),nl,nl,
    write("Please enter the code for the career option- (cse/csai/design/maths/ssh)"),
    read(Career).

input_cgpa(CGPA):-
    nl,nl, write("Please enter your CGPA: "),nl,
    read(CGPA).

input_BTP(BTP):-
    nl,nl, write("Have you completed or have an ongoing BTP/Internship in the Career option chosen above? (true/false) "),nl,
    read(BTP).

suggest_courses(Career,Semester):-
    elective(Career,Semester,Courses),
    get_prerequisites_of_courses(Courses,Prereqs),
    nl,nl,write("Please enter the prerequisites you have completed out of the following-"),
    write(Prereqs),
    write(". Enter 'endl.' when done."),nl,
    input_list(PrereqsCompleted),
    write("You have completed - "),write(PrereqsCompleted),nl,
    find_courses(Courses,PrereqsCompleted).

get_prerequisites_of_courses(Courses,Prereqs):-
    dict_pairs(Courses,_,Pairs), 
    pairs_values(Pairs,Values), 
    flatten(Values,Flattened_List), 
    sort(Flattened_List,Prereqs).

find_courses(Courses,PrereqsCompleted):-
    input_cgpa(CGPA),
    input_BTP(BTP),
    dict_pairs(Courses,_,P),
    pairs_values(P,V),
    pairs_keys(P,K),
    nl,nl,
    write("---------------------------------------Electives Advised------------------------------------------"),nl,nl,
    write("We recommend the following electives for you- "),nl,nl,
    recommend_courses(K,V,PrereqsCompleted,CGPA,BTP),
    nl,nl,write("All the best for your upcoming semester!").


recommend_courses([H1|T1],[H2|T2],PrereqsCompleted,CGPA,BTP):-
    subtract(H2,PrereqsCompleted,R),
    recommend_current_course(R,H1,CGPA,BTP),
    recommend_courses(T1,T2,PrereqsCompleted,CGPA,BTP).

recommend_courses([],[],_,_,_).

recommend_current_course(R,H1,CGPA,BTP):-
    length(R,N),
    (
        N=:=0, (CGPA>=8;BTP;easyMedium(H1)) -> write(H1),nl
        ;write("")
    ).

input_list([H|T]):- write("Enter course"),read(H),dif(H,endl), input_list(T).
input_list([]). 