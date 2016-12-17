{
/*
   Name: English Gaming System
   Author:  Chan Ngo Yin
   Description: N/A
   Copyright:   Creative Commons 4.0
*/
}
{ver.beta2}
program english_game_system;
uses crt;
label 1,2,3,4,logout,logout_menu,Rankmenu,  c_1,c_2,c_3,c_4,c_logout_menu,c_Rankmenu,exitadmin;
	type
		usertype= record
				  name:string;
				  pw:string;
				  money:integer;
				  classs:string[2];
				  end;
	type
		admintype= record
				   pin:string;
				   end;

var
	letter:char;
	loop:integer;
	driver,mode:integer;
	infile:text;
	money:integer;
	x:char;
	i:integer;
    name:string;
	user:array[1..100] of usertype;
	totaluser:integer;
	ID:integer;
	all:integer;
	c:integer;
	admin_infile:text;
	secret:string;
	solution:string;
	done:boolean;
	noofattempts:integer;
	

PROCEDURE draw_window(left, top, right, bottom : integer);
VAR
  i : integer;
BEGIN
  GotoXY(left,top);
  write(#201);                  (* draw left top *)
  FOR i := left+1 TO right-1 DO
     write(#205);
  write(#187);                  (* draw right top *)
  GotoXY(left,bottom);
  write(#200);                  (* draw left bottom *)
  FOR i := left+1 TO right-1 DO
     write(#205);
  write(#188);                  (* draw right bottom *)
  GotoXY(left,top+1);
  FOR i := top+1 TO bottom-1 DO
  BEGIN
     write(#186);
     GotoXY(left,i+1)
  END;
  GotoXY(right,top+1);
  FOR i := top+1 TO bottom-1 DO
  BEGIN
     write(#186);
     GotoXY(right,i+1)
  END
END;

procedure profile;
begin
window(73,3,101,26);
textbackground(white);
clrscr;
textcolor(blue);
{words of menu}
writeln;writeln;writeln;writeln;writeln;writeln;
writeln('          Profile');writeln;
writeln('   User  Name : ',user[ID].name);writeln;
writeln('   User Class : ',user[ID].classs);writeln;
writeln('   Money    $ : ',user[ID].money);writeln;
writeln;
writeln(' Press E to change password');
end;

procedure changepw;
var
CPW,Npw:string;
begin

    window(1,1,120,30);
textbackground(black);
clrscr;
window(1,1,120,6);
textbackground(cyan);
gotoxy(1,1);
clrscr;
textcolor(black);
writeln;
writeln('   ___ _                         ___                              _ ');
writeln('  / __| |_  __ _ _ _  __ _ ___  | _ \__ _ _______ __ _____ _ _ __| |');
writeln(' | (__| '' \/ _` | '' \/ _` / -_) |  _/ _` (_-<_-< V  V / _ \ ''_/ _` |');
writeln('  \___|_||_\__,_|_||_\__, \___| |_| \__,_/__/__/\_/\_/\___/_| \__,_|');
writeln('                     |___/                                          ');
                                                
                      

window(20,10,100,24);
textcolor(black);
textbackground(white);
gotoxy(1,1);
clrscr;

writeln('Current Password : ');
readln(cpw);
if cpw= user[ID].pw then begin
	writeln('New Password : ');
	readln(npw);
	user[ID].pw:=npw;
	writeln('Password changed !');
	delay(1000);
	end
	else begin writeln('wrong password'); delay(1000);end;
	window(1,1,120,30);
textbackground(blue);
clrscr;
end;
{=====================Secret Word========================}
procedure letterGuess;
	begin
		write('Input letter that you are going to guess: ');
		letter:= readkey;
		writeln;
		clrscr;
		for loop:=1 to length(secret) do
			if letter=secret[loop] then
				solution[loop]:=letter;
			writeln(solution);
			noofattempts:= noofattempts-1;
			writeln('No. of Attempts remaining = ', noofattempts)
		end;
		
procedure wincheck;
	begin
		if(solution=secret) or (noofattempts=0) then
			done:=true;
end;

procedure selectsecret(var secret:string) ;
var
	word:array[1..50]of string;
	infile_guess:text;
	noofword:integer;
begin
	assign(infile_guess,'file_game3/data.txt');
	reset(infile_guess);
	loop:=0;
	while not eof(infile_guess) do	begin
		loop:= loop+1;
		readln(infile_guess,word[loop]);
	end;
	noofword:=loop;
	randomize;
	secret:=word[random(noofword)+1];
end;
procedure init_guess;
begin
			solution:='';
			for loop:=1 to length(secret)do
				solution:= solution+'*';
			noofattempts:=3*length(secret)
end;
procedure SecretWord;
var
total:integer;
begin

	   total:=0;
    window(1,1,120,30);
textbackground(black);
clrscr;
window(1,1,120,6);
textbackground(lightred);
gotoxy(1,1);
clrscr;
textcolor(black);
writeln;
writeln('     ___                 _    __      __          _ ');
writeln('    / __| ___ __ _ _ ___| |_  \ \    / /__ _ _ __| |');
writeln('    \__ \/ -_) _| ''_/ -_)  _|  \ \/\/ / _ \ ''_/ _` |');
writeln('    |___/\___\__|_| \___|\__|   \_/\_/\___/_| \__,_|');
                                                
                                                
                      

window(20,10,100,24);
textcolor(black);
textbackground(white);
gotoxy(1,1);
clrscr;
textcolor(black);
	selectsecret(secret);
	init_guess;
	done:=false;
	writeln('The secret word to be guessed is ', solution);
	writeln('No. of Attempts remaining = ', noofattempts);
	writeln;
	repeat
		letterGuess;
		wincheck;
	until done = true;
	if solution= secret then begin
		writeln('Mission Success !');
		writeln('Money $ +20');
		money:=money+20;
		delay(1000);
		end
		else begin writeln('Mission Failure'); 
		writeln('Money $ -10');
		money:=money-10;
		delay(1000);
		end;
		writeln;
   user[ID].money:=money;
   window(1,1,120,30);
   textbackground(blue);
   clrscr;

	
end;
{====================/secret Word============================}
{login info}
procedure initial;
begin
	assign(infile,'profiles/userdata.txt');
	reset(infile);
	all:=0;
	totaluser:=0;
	while not eof(infile) do begin
	totaluser := totaluser+1;
	all:=all+1;
		with user[totaluser]do
		begin readln(infile,name);
			  readln(infile,pw);
			  readln(infile,money);
			  readln(infile,classs);
		end;
	end;
	close(infile);
end;

procedure login;
var
	target_name,target_pw:string;
	
	pass:boolean;
begin
	initial;
	window(0,0,25,117);
	textbackground(blue);
	clrscr;

pass:=false;
while not pass do begin
window(1,1,120,30);
textbackground(black);
clrscr;
window(1,1,120,6);
textbackground(green);
gotoxy(1,1);
clrscr;
textcolor(black);
writeln('      _              _      ');
writeln('     | |   ___  __ _(_)_ _  ');
writeln('     | |__/ _ \/ _` | | '' \ ');
writeln('     |____\___/\__, |_|_||_|');
writeln('               |___/        ');

window(20,10,100,24);
textcolor(blue);
textbackground(white);
gotoxy(1,1);
clrscr;
textcolor(black);
writeln;
writeln;
writeln('!!!For Preventing account spam problem, Register should be done in admin area!!!');
writeln;

gotoxy(9,23);
write('     User name : ');
readln(target_name);
writeln;
write('     Password : ');
readln(target_pw);
for i:=1 to totaluser do begin
if (target_name = user[i].name) and (target_pw = user[i].pw)
then begin pass := true ; ID:=i; end;
end;
end;
   money:=user[ID].money;
   name:=user[ID].name;
end;

	
	
	
procedure save;
var
	infile:text;
begin
	assign(infile,'profiles/userdata.txt');
	rewrite(infile);
	totaluser:=0;
for c:=1 to all  do begin
	totaluser := totaluser+1;
		writeln(infile,user[totaluser].name);
		writeln(infile,user[totaluser].pw);
		writeln(infile,user[totaluser].money);
		writeln(infile,user[totaluser].classs);
		
	end;
	close(infile);
end;
{===============================================================}



Procedure odd_one_out;
var
   rand:integer;
   uans,ch:char;
   ans:string;
   question1,question2,question3,question4:string;
   total:integer;
   times:integer;
   ask:char;
   q:integer;
   j:integer;
   k:integer;
   questionfileodd:text;
   ansfileodd:text;
begin
   Assign(questionfileodd,'file_game2/question.txt');
   assign(ansfileodd,'file_game2/answer.txt');
   reset(questionfileodd);
   reset(ansfileodd);
   total:=0;
    window(1,1,120,30);
textbackground(black);
clrscr;
window(1,1,120,6);
textbackground(yellow);
gotoxy(1,1);
clrscr;
textcolor(black);
writeln;
writeln('        ___     _    _                           _   ');
writeln('       / _ \ __| |__| |  ___ _ _  ___   ___ _  _| |_ ');
writeln('      | (_) / _` / _` | / _ \ '' \/ -_) / _ \ || |  _|');
writeln('       \___/\__,_\__,_| \___/_||_\___| \___/\_,_|\__|');
                                                
                      

window(20,10,100,24);
textcolor(black);
textbackground(white);
gotoxy(1,1);
clrscr;
textcolor(black);  
   while not eof(questionfileodd) do begin
   readln(questionfileodd);
   readln(questionfileodd);
   readln(questionfileodd);
   readln(questionfileodd);
   total:=total+1
   end;
writeln(total,' Odd one out');

   randomize;
   repeat
   repeat
   TextColor(black);
   writeln('How many questions you want challenge? ');
   readln(times);
   clrscr;
   
      write(times,' Questions You Wanna Challenge, Really? ');
	
	
	
      ask := readkey;
	  clrscr;
	  if (ask <>'n' )and (ask <>'N') and (ask <>'y') and ( ask <>'Y') then writeln('Wrong selection');
	  until ask in ['n','N','y','Y'];
   until ask  in ['y', 'Y'];	

   for q:= 1 to times do begin
        clrscr;
		TextColor(blue);
		if money < 0 then exit;
        rand:=random(total)+1;
		reset(questionfileodd);
		reset(ansfileodd);
	
	for j:= 1 to rand do begin
				readln(questionfileodd,question1);
				readln(questionfileodd,question2);
				readln(questionfileodd,question3);
				readln(questionfileodd,question4);
	end;
	
	for k:= 1 to j do begin
				readln(ansfileodd,ans);
	end;
	repeat
	clrscr;
	writeln('Odd One Out');
	writeln('   ___ _                                    ');
	writeln('  / __| |_  ___  ___ ___ ___   ___ _ _  ___ ');
	writeln(' | (__| '' \/ _ \/ _ (_-</ -_) / _ \ '' \/ -_)');
	writeln('  \___|_||_\___/\___/__/\___| \___/_||_\___|');
             
	writeln(question1);
	writeln(question2);
	writeln(question3);
	writeln(question4);
    
	  writeln;
	  ch := readkey;
	  case  ch of
	  'a': begin uans:='A' end;
	  'b': begin uans:='B' end;
	  'c': begin uans:='C' end;
	  'd' :begin uans:='D' end;
	  end;
	if (ch <>'a') or (ch <>'b') or (ch <>'c') or (ch <>'d') then writeln('Wrong Input!!!');
    until ch in['a'..'d'];		
	
	
	
	
    if uans = ans
		then begin clrscr; TextColor(lightGreen); writeln('Correct !'); writeln('Money+10'); user[ID].money := user[ID].money+10 ;delay(1000);end
		else begin clrscr; TextColor(lightRed); writeln('Incorrect !'); writeln('Money-5'); user[ID].money := user[ID].money-5;  end;
	TextColor(white);
		writeln('You now have : ');
		writeln('$ ', user[ID].money);
		delay(1000);
	if money < 0 then begin writeln('Bankruptcy Account!!'); readln; halt;end;

end;
	writeln('All Question answered');
	delay(1000);
   money:=user[ID].money;
   name:=user[ID].name;
   close(questionfileodd);
   close(ansfileodd);
      window(1,1,120,30);
   textbackground(blue);
   clrscr;
end;



{=========================================================================}
procedure Riddle;
var
   rand:integer;
   uans:string;
   ans:string;
   question:string;
   total:integer;
   times:integer;
   q:integer;
   j:integer;
   k:integer;
   ask:char;
   questionfile:text;
   ansfile:text;
begin
   Assign(questionfile,'file_game1/question.txt');
   assign(ansfile,'file_game1/answer.txt');
   reset(questionfile);
   reset(ansfile);
   total:=0;
 window(1,1,120,30);
textbackground(black);
clrscr;
window(1,1,120,6);
textbackground(blue);
gotoxy(1,1);
clrscr;
textcolor(white);
writeln;
writeln('       ___ _    _    _ _     ');
writeln('      | _ (_)__| |__| | |___ ');
writeln('      |   / / _` / _` | / -_)');
writeln('      |_|_\_\__,_\__,_|_\___|');
                      

window(20,10,100,24);
textcolor(black);
textbackground(white);
gotoxy(1,1);
clrscr;
textcolor(black);  
   while not eof(ansfile) do begin
   readln(ansfile);
   total:=total+1
   end;
writeln(total,' questions in total');

   randomize;
   TextColor(black);
   repeat
   repeat
   writeln('How many questions you want challenge? ');
   readln(times);
   clrscr;
   
      write(times,' Questions You Wanna Challenge, Really? ');
	
	
	
      ask := readkey;
	  clrscr;
	  if (ask <>'n' )and (ask <>'N') and (ask <>'y') and ( ask <>'Y') then writeln('Wrong selection');
	  until ask in ['n','N','y','Y'];
   until ask  in ['y', 'Y'];		

   for q:= 1 to times do begin
        clrscr;
		TextColor(black);
		if money < 0 then exit;
        rand:=random(total)+1;
		reset(questionfile);
		reset(ansfile);
	
	for j:= 1 to rand do begin
				readln(questionfile,question);
	end;
	
	for k:= 1 to j do begin
				readln(ansfile,ans);
	end;
	writeln(question);
    readln(uans);
    if uans = ans
		then begin clrscr; TextColor(lightGreen); writeln('Correct !'); writeln('Money+10'); user[ID].money := user[ID].money+10 ;delay(1000);end
		else begin clrscr; TextColor(lightRed); writeln('Incorrect !'); writeln('Money-5'); user[ID].money := user[ID].money-5;  end;
	TextColor(white);
		writeln('You now have : ');
		writeln('$ ', user[ID].money);
		delay(1000);;
	if money < 0 then begin writeln('Bankruptcy Account!!'); readln; halt;end;

end;
writeln('All Question answered');
delay(500);
   money:=user[ID].money;
   name:=user[ID].name;
   close(questionfile);
   close(ansfile);
   window(1,1,120,30);
   textbackground(blue);
   clrscr;
end;



procedure sort;
var p,q,temp_money:integer; 
	temp_name,temp_pw:string;
	temp_classs:string[2];
	h:integer;
begin
for p:= totaluser downto 1 do 
		for q:= 2 to p do
			if user[q-1].money<user[q].money then begin
				temp_money:= user[q-1].money;
				temp_name:= user[q-1].name;
				temp_pw:= user[q-1].pw;
				temp_classs:= user[q-1].classs;
				{hehehehehe}					
				user[q-1].money:=user[q].money;
				user[q-1].name:=user[q].name;
				user[q-1].pw:=user[q].pw;
				user[q-1].classs:=user[q].classs;
				{hehehehehe}
				user[q].money:=temp_money;
				user[q].pw:=temp_pw;
				user[q].name:=temp_name;
				user[q].classs:=temp_classs;
				save;
			end;
			
			
end;





procedure Rank;
var
   index, align : integer;
begin
    window(1,1,120,30);
textbackground(black);
clrscr;
window(1,1,120,6);
textbackground(lightred);
gotoxy(1,1);
clrscr;
textcolor(black);
writeln;
writeln('        ___            __  ');
writeln('       / _ \___ ____  / /__');
writeln('      / , _/ _ `/ _ \/  ''_/');
writeln('     /_/|_|\_,_/_//_/_/\_\ ');
                      
                                                
                                                
                      

window(20,10,100,24);
textcolor(black);
textbackground(white);
gotoxy(1,1);
clrscr;
textcolor(black);
	sort;
	clrscr;
	textcolor(white);
   writeln('Rank');
   TextBackground(Brown);
     writeln('Rank',' ' ,'Name',' ':13,'Money',' ':4,'Class',' ':7    );
   TextBackground(0);
   for index := 1 to totaluser do
      with user[index] do
      begin
	     textBackground(cyan);
		 write(indeX,'    ');
		 align := 15 - length(name);  { space required to align promote column }
		 TextBackground(cyan);
         write(Name,' ':align);
		 TextBackground(red);
		 write(money,' ':6);
		 TextBackground(blue);
		 writeln(classs,' ':9);
      end;
	  TextBackground(0);
	  writeln('Press Enter to back to menu');
	  readln;
   window(1,1,120,30);
   textbackground(blue);
   clrscr;
end;  { DisplayRecord }







{===========================================================}

{admin_area}

procedure design_admin;
begin
 window(1,1,120,30);
textbackground(black);
clrscr;
window(1,1,120,6);
textbackground(blue);
gotoxy(1,1);
clrscr;
textcolor(white);
writeln;
writeln('    _      _       _        ___               _ ');
writeln('   /_\  __| |_ __ (_)_ _   | _ \__ _ _ _  ___| |');
writeln('  / _ \/ _` | ''  \| | '' \  |  _/ _` | '' \/ -_) |');
writeln(' /_/ \_\__,_|_|_|_|_|_||_| |_| \__,_|_||_\___|_|');
                                                
                      

window(20,10,100,24);
textcolor(black);
textbackground(white);
gotoxy(1,1);
clrscr;
textcolor(black);  
end;

procedure SaveRecord_admin;
var
   n : integer;
begin
   { writing updated records to text file }
   rewrite(infile);                         { prepares text file for writing }
   for n := 1 to totaluser do
      with user[n] do
      if name <> '$$$'                        { check for deleted records }
         then begin
         writeln(infile, Name);
		 writeln(infile, pw);
         writeln(infile, money);
         writeln(infile, classs);
              end;
		close(infile)
end;   { SaveRecord }






procedure InsertRecord;
var
   ans : char;
begin
   writeln('Register');
   append(infile);                    { append records to existing text file }
   repeat
   design_admin;
	  clrscr;
      totaluser := totaluser + 1;
	  all:=all+1;
      with user[totaluser] do
      begin
	  
         write('Enter contact name: ');
         readln(Name);
         write('Enter starting money : ');
         readln(money);
         write('Please enter the class ', name,' : ');
         readln(classs);
		 write('Please enter the password : ');
		 readln(pw);

         { writing records to text file }
         writeln(infile, Name);
		 writeln(infile, pw);
         writeln(infile, money);
         writeln(infile, classs);
		
      end;
	  repeat
      write('register more accouunt (Y/N)? ');
	
	
	
      ans := readkey;
	
	  if (ans <>'n' )and (ans <>'N') and (ans <>'y') and ( ans <>'Y') then writeln('Wrong selection');
	  until ans in ['n','N','y','Y'];
   until ans in ['N', 'n'];		{ loop continues until 'N' or 'n' is inputted }


end;  { InsertRecord }


procedure DisplayRecord;
var
   index, align : integer;
begin
design_admin;
	clrscr;
   writeln('Display Records');
   TextBackground(Brown);
     writeln('Name',' ':13,'Money',' ':4,'Class',' ':7     );
   TextBackground(0);
   for index := 1 to totaluser do
      with user[index] do
      begin
         align := 15 - length(name);  { space required to align promote column }
		 TextBackground(cyan);
         write(Name,' ':align);
		 TextBackground(red);
		 write(money,' ':15-4);
		 TextBackground(blue);
		 writeln(classs,' ':13-length(classs));
      end;
	  TextBackground(0);
	  writeln('Press Enter to back to menu');
	  readln
end;  { DisplayRecord }


procedure searchRecord;
var
   target_search : string[30];
   found : boolean;
   n, index : integer;
begin
design_admin;
	clrscr;
   writeln('Search User');
   write('Enter name of User: ');
   readln(target_search);
   found := false;
   n := 0;
   repeat
      n := n + 1;
      with user[n] do
        if Name = target_search
            then begin
                    index := n;
                    found := true
                 end
   until found or (n = totaluser);
   if found
      then begin
              writeln('User found!');
              with user[index] do
              begin
				 write('Name : ');
                 writeln(user[n].name);
                 write('Money : ');
                 writeln(user[n].money);
                 write('class : ');
                 writeln(user[n].classs);
              end
           end
      else writeln('User not found!');
	  writeln('Press Enter to back to menu...');
	  readln;
end;   { AmendRecord }




procedure AmendRecord;
var
   target_Amend : string[30];
   found : boolean;
   n, index : integer;
begin
design_admin;
	clrscr;
   writeln('Amend Records');
   write('Enter name of user to amend: ');
   readln(target_Amend);
   found := false;
   n := 0;
   repeat
      n := n + 1;
      with user[n] do
        if Name = target_Amend
            then begin
                    index := n;
                    found := true
                 end
   until found or (n = totaluser);
   if found
      then begin
              writeln('user record found!');
              with user[index] do
              begin
				 write('Enter Name: ');
                 readln(Name);
                 write('Enter Money: ');
                 readln(money);
                 write('Enter class: ');
                 readln(classs);
				 write('Enter password: ');
                 readln(pw);
                 writeln('Record updated!')
              end
           end
      else writeln('User name not found!');
	  SaveRecord_admin;
end;   { AmendRecord }






procedure adminmenu;
var
	ch:char;
	
begin
design_admin;
	clrscr;
	  textcolor(lightgreen);
	
      writeln('Admin Menu');
	  textcolor(yellow);
	  writeln('================');
      writeln;
	  textcolor(white);
      writeln('1. Register');
      writeln('2. Search    Records');
      writeln('3. Display   Records');
      writeln('4. Amend     Records');
      writeln('5. Exit  admin panel');
      repeat
	  writeln;
	  ch := readkey;
	  case  ch of
	  '1': begin InsertRecord;clrscr;adminmenu; end;
	  '2': begin searchRecord; clrscr;adminmenu; end;
	  '3': begin DisplayRecord; clrscr;adminmenu; end;
	  '4' :begin AmendRecord;clrscr;adminmenu; end;
	  '5': begin SaveRecord_admin;    window(1,1,120,30);
   textbackground(blue);
   clrscr; exit;end;
	
	  end;
	  until ch in['1'..'5'];	
end;

procedure adminpincheck;
var
    PINfile: text;
	target_pw:string;
	adminPW:string;
	pass:boolean;
	
begin
	assign(PINfile,'profiles/admin_area/PIN.bin');
	reset(PINfile);
	read(PINfile,adminPW);
	pass:=false;
	
	while not pass do begin
    	write('Type in admin PIN to get admin permission (Type "exit" to exit this page) : ');
		readln(target_pw);
		if  (target_pw = adminPW)
			then begin pass := true ;  end
			else if (target_pw = 'exit') then exit
				else begin pass := false; writeln('wrong PIN'); readln;clrscr; end;
	end;

	if pass=true
	then adminmenu;
	
	close(PINfile);
end;






procedure money_checker;
begin
if user[ID].money <0 then begin writeln('Bankruptcy Account!! Tell your teacher for the solution' );readln;halt; end;
end;




begin
initial;
sort;
save;
logout:
clrscr;
login;


if user[ID].name = 'admin' then begin adminmenu; goto exitadmin;end;

exitadmin:
money_checker;
clrscr;
writeln('Loading...');
Delay(500);
clrscr;
writeln('Loading....');
Delay(500);
clrscr;
writeln('Loading.....');
Delay(500);
clrscr;
gotoxy(1,1);
window(1,1,120,30);
textbackground(blue);
clrscr;
clrscr;




{English_ver}


1:

profile;
{name}
window(7,3,47,5);
textbackground(white);
clrscr;
textcolor(blue);
writeln;
writeln('Hello :' , user[ID].name);

{money}
window(50,3,70,5);
textbackground(white);
clrscr;
textcolor(blue);
{words of menu}
writeln;
writeln('   Money $ ',user[ID].money);

{option1}
window(7,8,25,10);
textcolor(blue);
textbackground(Yellow);
gotoxy(1,1);
writeln('Riddle');
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Riddle');


{option2}
window(7,12,25,14);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Odd One Out');

{option3}
window(7,16,25,18);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Secret Word');

{option4}
window(7,20,25,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Exit');



{Rank}
window(7,24,28,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Rank');


{option5}
window(30,24,70,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Logout');

{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            LogOut');
writeln;
writeln('   Logout');


{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            Riddle');
writeln;
writeln('   Answer what the question describe');


{readkey}
repeat
  x:=readkey;
  if ord(x)=80 then goto 2;
  if ord(x)=101 then begin changePW; goto 1;end;
  if ord(x)=13 then begin clrscr; Riddle; goto 1; end;

until (ord(x)=13) or (ord(x)=80);

;

4:
profile;
{name}
window(7,3,47,5);
textbackground(white);
clrscr;
textcolor(blue);
writeln;
writeln('Hello :' , name);


{money}
window(50,3,70,5);
textbackground(white);
clrscr;
textcolor(blue);
{words of menu}
writeln;
writeln('   Money $ ',money);

{option1}
window(7,8,25,10);
textcolor(blue);
textbackground(white);
gotoxy(1,1);
writeln('Riddle');
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Riddle');


{option2}
window(7,12,25,14);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Odd One Out');

{option3}
window(7,16,25,18);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Secret Word');

{option4}
window(7,20,25,22);
textbackground(yellow);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Exit');

{Rank}
window(7,24,28,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Rank');

{option5}
window(30,24,70,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Logout');

{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            LogOut');
writeln;
writeln('   Logout');


{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            Exit');
writeln;
writeln('   Press enter to exit this English         ');
writeln;
writeln('   learning system');

{readkey}
repeat
  x:=readkey;
  if ord(x)=72 then goto 3;
  if ord(x)=80 then goto Rankmenu;
  if ord(x)=13 then begin save; halt; end;
  if ord(x)=101 then begin changePW; goto 1;end;
  until ord(x)=13;
;






3:
{name}
profile;
{name}
window(7,3,47,5);
textbackground(white);
clrscr;
textcolor(blue);
writeln;
writeln('Hello :' , name);

{money}
window(50,3,70,5);
textbackground(white);
clrscr;
textcolor(blue);
{words of menu}
writeln;
writeln('   Money $ ',money);

{option1}
window(7,8,25,10);
textcolor(blue);
textbackground(white);
gotoxy(1,1);
writeln('Riddle');
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Riddle');


{option2}
window(7,12,25,14);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Odd One Out');

{option3}
window(7,16,25,18);
textbackground(yellow);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Secret Word');

{option4}
window(7,20,25,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Exit');

{Rank}
window(7,24,28,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Rank');

{option5}
window(30,24,70,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Logout');

{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            LogOut');
writeln;
writeln('   Logout');


{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            Secret Word');
writeln;
writeln('   Guess what it is');

{readkey}
repeat
  x:=readkey;
  if ord(x)=72 then goto 2;
  if ord(x)=80 then goto 4;
  if ord(x)=13 then begin clrscr; SecretWord; goto 3; end;
  if ord(x)=101 then begin changePW; goto 1;end;

  until ord(x)=13;
;








2:
profile;
{name}
window(7,3,47,5);
textbackground(white);
clrscr;
textcolor(blue);
writeln;
writeln('Hello :' , name);

{money}
window(50,3,70,5);
textbackground(white);
clrscr;
textcolor(blue);
{words of menu}
writeln;
writeln('   Money $ ',money);

{option1}
window(7,8,25,10);
textcolor(blue);
textbackground(white);
gotoxy(1,1);
writeln('Riddle');
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Riddle');


{option2}
window(7,12,25,14);
textbackground(yellow);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Odd One Out');

{option3}
window(7,16,25,18);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Secret Word');

{option4}
window(7,20,25,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Exit');

{Rank}
window(7,24,28,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Rank');


{option5}
window(30,24,70,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Logout');

{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            LogOut');
writeln;
writeln('   Logout');

{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            Odd One Out');
writeln;
writeln('   Find the difference');

{readkey}
repeat
  x:=readkey;
  if ord(x)=72 then goto 1;
  if ord(x)=80 then goto 3;
  if ord(x)=13 then begin clrscr; odd_one_out; goto 2; end;
  if ord(x)=101 then begin changePW; goto 1;end;

  until ord(x)=13;
;





logout_menu:
profile;
{name}
window(7,3,47,5);
textbackground(white);
clrscr;
textcolor(blue);
writeln;
writeln('Hello :' , name);

{money}
window(50,3,70,5);
textbackground(white);
clrscr;
textcolor(blue);
{words of menu}
writeln;
writeln('   Money $ ',money);

{option1}
window(7,8,25,10);
textcolor(blue);
textbackground(white);
gotoxy(1,1);
writeln('Riddle');
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Riddle');


{option2}
window(7,12,25,14);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Odd One Out');

{option3}
window(7,16,25,18);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Secret Word');

{option4}
window(7,20,25,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Exit');





{Rank}
window(7,24,28,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Rank');



{option5}
window(30,24,70,26);
textbackground(yellow);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Logout');

{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            LogOut');
writeln;
writeln('   Logout');

{readkey}
repeat
  x:=readkey;
  if ord(x)=72 then goto Rankmenu;
  if ord(x)=13 then begin save; goto logout; end;
  if ord(x)=101 then begin changePW; goto 1;end;

  until ord(x)=13;
;






Rankmenu:
profile;
{name}
window(7,3,47,5);
textbackground(white);
clrscr;
textcolor(blue);
writeln;
writeln('Hello :' , user[ID].name);

{money}
window(50,3,70,5);
textbackground(white);
clrscr;
textcolor(blue);
{words of menu}
writeln;
writeln('   Money $ ',user[ID].money);

{option1}
window(7,8,25,10);
textcolor(blue);
textbackground(white);
gotoxy(1,1);
writeln('Riddle');
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Riddle');


{option2}
window(7,12,25,14);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Odd One Out');

{option3}
window(7,16,25,18);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Secret Word');

{option4}
window(7,20,25,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Exit');



{Rank}
window(7,24,28,26);
textbackground(yellow);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Rank');


{option5}
window(30,24,70,26);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln('  Logout');

{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            LogOut');
writeln;
writeln('   Logout');


{description}
window(27,8,70,22);
textbackground(white);
clrscr;
{words of menu}
textcolor(blue);
writeln;
writeln;
writeln('            Rank');
writeln;
writeln('   Show Top users');


{readkey}
repeat
  x:=readkey;
  if ord(x)=80 then goto logout_menu;
  if ord(x)=72 then goto 4;
  if ord(x)=13 then begin clrscr; Rank; goto Rankmenu; end;
  if ord(x)=101 then begin changePW; goto 1;end;

until (ord(x)=13) or (ord(x)=80);

;








 end.

