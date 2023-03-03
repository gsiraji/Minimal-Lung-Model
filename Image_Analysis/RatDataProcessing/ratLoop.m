function ratLoop(data_all,day,sheetRowNum)

switch day
    case 0
        ventVec = [1 2];
        numAnimalIDs = 14;
    case 7
        ventVec = [1 2 5];
        numAnimalIDs = 9;
end



for i = 1:2
    for j = ventVec
        for k = 1:numAnimalIDs
            [i,j,k]
            try 
                data = data_all{i,j,k};
            catch
                break
            end
            
            if (isempty(data))
                break
            end

            sheetRowNum = sheetRowNum + 1;
            Treatment = string(data.Treatment);
            Ventilation = string(data.ventType);
            HR = data.HR;
            if isempty(HR)
                HR = 0;
            end
            sex = data.sex;
            G_mean = mean(data.FOT_PEEP2.G(data.FOT_PEEP2.goodinds));
            G_std = std(data.FOT_PEEP2.G(data.FOT_PEEP2.goodinds));
            G_median = median(data.FOT_PEEP2.G(data.FOT_PEEP2.goodinds));
            H_mean = mean(data.FOT_PEEP2.H(data.FOT_PEEP2.goodinds));
            H_std = std(data.FOT_PEEP2.H(data.FOT_PEEP2.goodinds));
            H_median = median(data.FOT_PEEP2.H(data.FOT_PEEP2.goodinds));
            Rn_mean = mean(data.FOT_PEEP2.Rn(data.FOT_PEEP2.goodinds));
            Rn_std = std(data.FOT_PEEP2.Rn(data.FOT_PEEP2.goodinds));
            Rn_median = median(data.FOT_PEEP2.Rn(data.FOT_PEEP2.goodinds));
            ID = str2double(extract(data.ID, digitsPattern));
            
            Cst = data.PV.Cst;
            try
                IC = data.PV.IC;
            catch
                IC = [0,0];
            end
            A = data.PV.A;
            K = data.PV.K;


            if ~isempty(ID) 
                ID = ID(1);
            else
                ID = 0;
            end
            IDstring = string(data.ID);
            
            switch j
                case 1
                    suggestedVent = "SAFE";
                case 2
                    suggestedVent = "P20";
                case 5
                    suggestedVent = "P24";
            end

            %     IDstring= [string(IDstring(1,1:3))];
%             range1 = strcat('A',num2str(sheetRowNum),':Q',num2str(sheetRowNum));
%             Table1 = table(day, ID,IDstring, HR, Treatment, Ventilation,suggestedVent, sex, G_mean, G_std, G_median, H_mean, H_std, H_median,...
%                 Rn_mean, Rn_std, Rn_median);

                        range1 = strcat('Q',num2str(sheetRowNum),':AA',num2str(sheetRowNum));
            Table1 = table(Cst(1),Cst(2),mean(Cst),IC(1),IC(2),mean(IC),A(1),A(2),mean(A),mean(K),IDstring);
            writetable(Table1, 'rat_data.xlsx', 'Range',...
                range1,'WriteVariableNames',0)

        end
    end
end