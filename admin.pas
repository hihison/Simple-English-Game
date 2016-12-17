{===========================================================}

{admin_area}


program admin;
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


var
	ch:char;

begin 

	login;
	1:
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
	  '1': begin InsertRecord;clrscr;goto 1; end;
	  '2': begin searchRecord; clrscr;goto 1; end;
	  '3': begin DisplayRecord; clrscr;goto 1; end;
	  '4' :begin AmendRecord;clrscr; goto 1;end;
	  '5': begin SaveRecord_admin;    window(1,1,120,30);
   textbackground(blue);
   clrscr; exit;end;
	
	  end;
	  until ch in['1'..'5'];	
end.