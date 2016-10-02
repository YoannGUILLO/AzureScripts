Function Connect-AzureARM
{
	Try    
	{
	#Import AzureRM.Profile module if not already loaded
	If (-not (Get-Module AzureRM.Profile -ErrorAction SilentlyContinue))
		{
		Import-Module AzureRM.Profile
		}
		
		#Connect to Azure
		Add-AzureRmAccount | Out-Null
		
		#Display Azure subscription, select one
		$SubscriptionName = Get-AzureRmSubscription | Out-GridView -OutputMode Single -Title "Select your suscription" | Select-Object -ExpandProperty SubscriptionName
		
		#Set the Azure subscription selected
		Set-AzureRmContext -SubscriptionName $SubscriptionName | Out-Null
		
		#Display Azure subscription selected
		$Context = Get-AzureRmContext
		$SubscriptionName = $Context.Subscription.SubscriptionName
		$Account = $Context.Account.Id
		
		Write-Host -ForegroundColor Green "Connected on $SubscriptionName with $Account"
	}
	Catch
	{
		Write-Host -ForegroundColor Red ("-"*(($(((Get-Host).UI.RawUI).BufferSize).Width)-1))
		Write-Host -ForegroundColor Red "Script file : $($_.InvocationInfo.ScriptName)"
		Write-Host -ForegroundColor Red "Line : `[$($_.InvocationInfo.ScriptLineNumber)`] $($_.InvocationInfo.Line)" -NoNewline
		Write-Host -ForegroundColor Red "Command : $($_.InvocationInfo.MyCommand)"
		Write-Host -ForegroundColor Red ("-"*(($(((Get-Host).UI.RawUI).BufferSize).Width)-1))
  		Write-Host -ForegroundColor Red "Error Details : $($_)"
		Write-Host -ForegroundColor Red ("-"*(($(((Get-Host).UI.RawUI).BufferSize).Width)-1))
	}
}

#Example : 
Connect-AzureARM