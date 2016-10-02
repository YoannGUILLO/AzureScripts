Function Connect-AzureASM
{
	Try    
	{
	#Import Azure module if not already loaded
	If (-not (Get-Module Azure -ErrorAction SilentlyContinue))
		{
		Import-Module Azure
		}
		
		#Connect to Azure
		Add-AzureAccount | Out-Null
		
		#Display Azure subscription, select one
		$SubscriptionName = Get-AzureSubscription | Out-GridView -OutputMode Single -Title "Select your suscription" | Select-Object -ExpandProperty SubscriptionName
		
		#Set the Azure subscription selected
		Select-AzureSubscription -SubscriptionName $SubscriptionName | Out-Null
		
		#Display Azure subscription selected
		$Subscription = Get-AzureSubscription -Current
		$SubscriptionName = $Subscription.SubscriptionName
		$Account = $Subscription.DefaultAccount
		
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
Connect-AzureASM