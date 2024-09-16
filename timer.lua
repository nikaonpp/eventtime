local checkInterval = 10 -- Intervalo de verificação em segundos

-- Função para checar o TimerLabel e executar o comando se o tempo for maior que 4 minutos
local function checkTimerLabel()
    local label = game:GetService("Workspace").Interiors["MainMap!Default"].Event.Ocean2024Exterior.JoinZone.Billboard.BillboardGui.TimerLabel

    -- Verifica se o texto contém "PRÓXIMO JOGO EM:"
    if label and string.find(label.Text, "PRÓXIMO JOGO EM:") then
        -- Extrai o tempo restante do texto
        local timeRemaining = string.match(label.Text, "%d%d:%d%d")
        
        -- Divide o tempo em minutos e segundos
        local minutes, seconds = string.match(timeRemaining, "(%d%d):(%d%d)")
        minutes = tonumber(minutes)
        seconds = tonumber(seconds)

        -- Mostra o tempo no console
        print("Tempo restante:", minutes .. ":" .. seconds)

        -- Se o tempo for maior que 4 minutos, executa a compra
        if minutes >= 4 then
            print("Tentando realizar a compra no jogo...")
            game:GetService("ReplicatedStorage").API:FindFirstChild("OceanAPI/AttemptPurchaseDive"):InvokeServer()
        else
            print("Tempo menor que 4 minutos, aguardando.")
        end
    else
        print("TimerLabel não encontrado ou não corresponde ao padrão.")
    end
end

-- Função para executar a verificação em intervalos regulares
while true do
    checkTimerLabel()
    wait(checkInterval)
end
