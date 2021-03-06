%% 计算适应度
function [result,A]=fitness(num,rule)%%原始数据，规则rule,这边开始每一次都传入一个rule
%% 开始原始数据和规则进行判断
    A=zeros(2,2);%存放四种计算情况的数组
     [numberleft,numberright,number] =rulebreak(rule);
    for ii=1:693 %%一共多少行
        tr=0;
        j=1;%%原始数据的第几行
        istrue=1;%%假设为真
        des=num(ii,:); %%来自原始数据     
        for i=1:3%%19个属性    这边是根据19个属性用来判断 是否符合规则的0和1
            %desr=rule(:,i); %%来自规则表第i列
            val=des(j); %%获取原始数据的第ii行第j列 
            pos=0;%%如果规则没有一次满足，则表明数据肯定不满足规则，则pos一定一直为 1
            for m=1:number(1,i) %%跟规则表里面的数据作比较  
               try
                  mm1=numberleft(m,i);
                  mm2=numberright(m,i);
                   if (mm1<=val && mm2>=val) %%进行比较看原始数据val是否满则规则表
                       pos=1;%%满足则规则 pos=1 即是 满足规则
                       break;
                   else
                       pos=0;
                   end
               catch
                  break; 
               end
           end
            %进行判断18个属性
           if pos==1%%当每一次属性判断都唯一的时候 tr就会加1
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
      %% 进行判断
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
%% 计算适应度
        precision=(A(2,2)+A(1,1))/(A(2,2)+A(1,2)+A(2,1)+A(1,1));
        recall=(A(1,1)/(A(1,1)+A(1,2)))+(A(2,2)/(A(2,1)+A(2,2)));
        result=2*precision*recall/(precision+recall);
end

