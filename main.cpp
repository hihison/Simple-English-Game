#include "group5.h"
//���MAIN��UI���ܤ� 
int score = readfile();
char menu;
//Created by hihison 
void animation(){
	system("cls");
	system("COLOR 70");
	printf("\n                                                ����̤j���C���t��               \n");
	delay(0.5);
	printf("                                                 �W");
	delay(0.2);
	printf("     �u");
	delay(0.2);
	printf("     �o\n");   
	delay(0.5);	
}
void printmenu(){ //�ڪ��D�H�O hihison 
	score = readfile();
	system("mode con:cols=120 lines=30");
	system("cls");
	system("COLOR 70");
	printf("\n                                                ����̤j���C���t��               \n");
	
	printf("                                                 �W");
	
	printf("     �u");
	
	printf("     �o\n");   
	
	//�W�u�o!! (�U�u��) 
	printf("            ��������������������������������������������������������������������������������������������\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��                  �|�ӹC�����g���                                                      ��\n");
	printf("            ��                                                                                        ��\n");	
	printf("            ��                  1. Riddle                                                             ��\n");	
	printf("            ��                                                                                        �� \n");	
	printf("            ��                  2. �|�D��                                                             ��\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��                  3. �q�Ʀr                                                             ��\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��                  4. �ܤ@�I                                                             ��\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��                  �ХH�Ʀr����,�� �Ʀr0 ���}���t�� ...                                ��\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��������������������������������������������������������������������������������������������\n");
	printf("            ��������������������������������������������������������������������������������������������\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��                �{������ : %d                                                          ��\n",score);
	printf("            ��                                                                                        ��\n");
	printf("            ��                                                                                        ��\n");
	printf("            ��������������������������������������������������������������������������������������������\n");
}
int main(){
	if (score<0){
		MessageBox(NULL, "YOU DONT HAVE ENOUGH SCORE TO PLAY ON THIS SYSTEM !", "ERROR", MB_OK);
		exit(1);
	}
	readfile();
	printf("");
	
	int imenu = 1;
	animation();
	do{
		printmenu();
		menu = getch();
		imenu = menu - '0';

		switch(imenu){
			case 1:
				system("cls");
				riddle();
				break;
			case 2 :
				system("cls");
				
				shetiqi();
				break;
			case 3:
				system("cls");
				guessnum();
				break;
			case 4:
				system("cls");
				bj();
				break;
			
		};
		if (imenu<0||imenu>4) {
			printf("Wrong Choice!"); 
			delay(0.1);
		}
	} while (imenu!=0);
	MessageBox(NULL, "Good Bye!", "Bye", MB_OK);
	savefile(score);
	system("color  00");
	
}


