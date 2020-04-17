$target_dir = ".\kubeconfig\"

Write-Host -ForegroundColor Yellow "stopping vagrant..."
vagrant halt

Write-Host -ForegroundColor Yellow "stopping minikube..."
minikube stop

Write-Host -ForegroundColor Yellow "deletting kubeconfig directory..."
If (Test-Path $target_dir) {
	Remove-Item -Path $target_dir -Recurse
} 
