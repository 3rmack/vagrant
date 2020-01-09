$source_dir_minikube = "~\.minikube\"
$source_dir_kube = "~\.kube\"
$target_dir = ".\kubeconfig\"

Write-Host -ForegroundColor Yellow "starting minikube..."
minikube start

Write-Host -ForegroundColor Yellow "creating required directory..."
If (-not (Test-Path $target_dir)) {
	New-Item -ItemType Directory -Path $target_dir -Force | Out-Null
} 

Write-Host -ForegroundColor Yellow "copying ca.crt..."
Copy-Item $source_dir_minikube\ca.crt $target_dir

Write-Host -ForegroundColor Yellow "copying client.crt..."
Copy-Item $source_dir_minikube\client.crt $target_dir

Write-Host -ForegroundColor Yellow "copying client.key..."
Copy-Item $source_dir_minikube\client.key $target_dir

Write-Host -ForegroundColor Yellow "copying config..."
Copy-Item $source_dir_kube\config $target_dir

Write-Host -ForegroundColor Yellow "modifying kubeconfig..."
(Get-Content -path $target_dir\config -Raw) -replace 'certificate-authority\:\s[a-zA-Z]:\\[\\\S|*\S]?.*','certificate-authority: ca.crt' -replace 'client-certificate\:\s[a-zA-Z]:\\[\\\S|*\S]?.*','client-certificate: client.crt' -replace 'client-key\:\s[a-zA-Z]:\\[\\\S|*\S]?.*','client-key: client.key' | Set-Content -Path $target_dir\config

Write-Host -ForegroundColor Yellow "starting vagrant..."
vagrant up
