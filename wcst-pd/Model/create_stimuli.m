%% Create and shuffle a deck of cards structure
% For this sets of simulations, stimuli are unambigous

% Code for Shapes 1,2,3,4    {'triangle','star','cross','circle'}
% Code for Numbers 1,2,3,4   {'1','2','3',4'}
% Code for Colours 1,2,3,4   {'red','green','yellow','blue'}

% Card on the table [1 1 1], [2 2 2], [3 3 3], [4 4 4]

stimuli = struct();
load('stimuli.mat')

itemnums = [1 2 3 4];
shapes = [1 2 3 4];
colours = [1 2 3 4];

%%{
for ii = 1:card_numbers
   
   card_set = [1 2 3];
   if rand > perc_ambig
    card_set = randperm(4,3);             % For unambigous cards
   else
    while length(unique(card_set)) >= 3     % Make sure it's ambigous
     card_set = randi([1 4],1,3);           % For ambigous cards
    end
   end
   
   stimuli(ii).itemnum = card_set(1);
   stimuli(ii).shape = card_set(2);
   stimuli(ii).colour = card_set(3);
   
end
%%}

%% Cards on the table

cardsTable(1).colour = 1;
cardsTable(2).colour = 2;
cardsTable(3).colour = 3;
cardsTable(4).colour = 4;

cardsTable(1).shape = 1;
cardsTable(2).shape = 2;
cardsTable(3).shape = 3;
cardsTable(4).shape = 4;

cardsTable(1).itemnum = 1;
cardsTable(2).itemnum = 2;
cardsTable(3).itemnum = 3;
cardsTable(4).itemnum = 4;

clear shapes; clear itemnums; clear colours;

clear ii; 