��SQL SERVER�������滻�ַ����ķ��� 

update table[����] set Fields[�ֶ���]=replace(Fields[�ֶ���],'���滻ԭ����','Ҫ�滻 

�ɵ�����') 

update ProgInfo set JoinTime=replace(JoinTime,'2007-3-2','2007-03-02') 

ʵ���� 

���⣺ĳ���ݿ��� flash �� �� url �ֶ� 

�������ҵ�url�ֶ�������� 

game.��ַ.com/���䲿�� 

�����ĳ� 

game_new.��ַ.com/���䲿�� 

ֻ��ǰ�벿�֣� 

��֪����ô��SQL����أ� 


�� 

����һ�� 

update flash set url=replace(url,'game','game_new') 

�������� 

update flash set url=replace(url,substring(url,1,4),'game_new')