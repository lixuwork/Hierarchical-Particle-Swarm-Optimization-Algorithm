%% ������Ӧ��
function [result,A]=fitness(num,rule)%%ԭʼ���ݣ�����rule,��߿�ʼÿһ�ζ�����һ��rule
%% ��ʼԭʼ���ݺ͹�������ж�
    A=zeros(2,2);%������ּ������������
     [numberleft,numberright,number] =rulebreak(rule);
    for ii=1:693 %%һ��������
        tr=0;
        j=1;%%ԭʼ���ݵĵڼ���
        istrue=1;%%����Ϊ��
        des=num(ii,:); %%����ԭʼ����     
        for i=1:3%%19������    ����Ǹ���19�����������ж� �Ƿ���Ϲ����0��1
            %desr=rule(:,i); %%���Թ������i��
            val=des(j); %%��ȡԭʼ���ݵĵ�ii�е�j�� 
            pos=0;%%�������û��һ�����㣬��������ݿ϶������������posһ��һֱΪ 1
            for m=1:number(1,i) %%�������������������Ƚ�  
               try
                  mm1=numberleft(m,i);
                  mm2=numberright(m,i);
                   if (mm1<=val && mm2>=val) %%���бȽϿ�ԭʼ����val�Ƿ���������
                       pos=1;%%��������� pos=1 ���� �������
                       break;
                   else
                       pos=0;
                   end
               catch
                  break; 
               end
           end
            %�����ж�18������
           if pos==1%%��ÿһ�������ж϶�Ψһ��ʱ�� tr�ͻ��1
                tr=tr+1;
                j=j+1;
           else
               break;
           end
        end
        
        if(tr==3)
            istrue=1;
        else
            istrue=0;
        end
      %% �����ж�
        RulerClass=str2double(rule(1,4));           
        DataClass=des(4);
        if RulerClass==1
            if istrue==1
                if RulerClass==DataClass
                    A(1,1)=A(1,1)+1;%observed intensifying predicted intensifying
                else
                    A(2,1)=A(2,1)+1;%observed weakening predicted intensifying
                end
            else
                RulerClass=-1;
                if RulerClass==DataClass
                    A(2,2)=A(2,2)+1;%observed weakening predicted weakening
                else
                    A(1,2)=A(1,2)+1;%observed intensifying predicted weakening
                end
            end
        end
        
        if RulerClass==0
            RulerClass=-1;
            if istrue==1
                if RulerClass==DataClass
                    A(2,2)=A(2,2)+1;%observed weakening predicted weakening
                else
                    A(1,2)=A(1,2)+1;%observed intensifying predicted weakening
                end
            else
                RulerClass=1;
                if RulerClass==DataClass
                    A(1,1)=A(1,1)+1;%observed intensifying predicted intensifying
                else
                    A(2,1)=A(2,1)+1;%observed weakening predicted intensifying
                end
            end
        end
        
    end
%% ������Ӧ��
        precision=(A(2,2)+A(1,1))/(A(2,2)+A(1,2)+A(2,1)+A(1,1));
        recall=(A(1,1)/(A(1,1)+A(1,2)))+(A(2,2)/(A(2,1)+A(2,2)));
        result=2*precision*recall/(precision+recall);
end
