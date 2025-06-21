local Telegram ={}
local HTTP = game:GetService('HttpService')
local success,data = pcall(function()
	return HTTP:GetSecret('token')
end)
Telegram.token=''
if success then
	Telegram.token=data
else
	warn('token not found',data)
end
function Telegram.SendMessage(msg:string)
	if Telegram.token=='' then return end
	local url = "https://api.telegram.org/bot"
	local suffix='/sendMessage'
	local UrlwithKey=Telegram.token:AddPrefix(url)
	local FinalUrl = UrlwithKey:AddSuffix(suffix)
	local response = HTTP:RequestAsync({
		Url=FinalUrl,
		Method='POST',
		Headers={
			['Content-Type']="application/json"
		},
		Body=HTTP:JSONEncode({
			chat_id=0,--ВАШ ID В ТЕЛЕГРАММ
			text=msg
		})
	})
end

function Telegram.PlayerJoined(plr:Player)
	if not plr then return end
	Telegram.SendMessage(string.format('%s joined!',plr.Name))
end
return Telegram
