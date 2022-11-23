function PasserTest($dest,$b){
    Write-Host
    while (1){
        $j=0
        $reponse=""
        $ext=""

        $file = Get-ChildItem -Path $dest -Recurse | Get-Random -Count 1 #Choisi un fichier aléatoirement
        $tab = $($file.name) -split "(.)"
        do{#recup nom fichier=reponse
            $reponse+= $tab[$j]
        }Until($tab[++$j] -eq ".")

        foreach ($rien in $tab){#recup extension fichier
            $ext+=$tab[++$j]
        }
        #Copie le fichier en le nommant powerTest et l'ouvre
        Copy-Item "$dest\$file" -Destination "$dest\powerTest.$ext"
        Invoke-Item ([io.fileinfo] "$dest\powerTest.$ext")
        $reponseHost = Read-Host "Entrez la réponse"#Demande la réponse
        Remove-Item "$dest\powerTest.*"#Supprimer le fichier temporaire
        if($reponseHost -eq "STOP"){break}#arreter ce domaine
        if($reponse -eq $reponseHost){
            Write-Host "Vrai,    réponse : $reponse"
            $rep[0]++
        }else{
            Write-Host "Faux,    réponse : $reponse"
            $rep[1]++
        }
    }
}

#----Début du "main"----

$destination = read-host "Entrez le chemin d'accès des langues"
Write-Host

$dossier = Get-ChildItem -Path $destination -Name -Exclude *.* #On récupère la liste des dossiers(juste nom) de ce répertoire (tout moins fichiers)
$i=0
$rep=0,0
<#foreach ($rien in $dossier){
    $vrai[$i]=0
    $faux[$i++]=0
}#>

do{
    $i=0
    write-Host
    Write-Host "Que voulez-vous travailler ?"
    foreach ($file in $dossier){
        Write-Host $i-$($dossier[$i++])
    }
    Write-Host "STOP-resultat et arrêt"
    $a = read-host "Entrez votre choix"
    
    if($a -ne "STOP"){PasserTest "$destination\$($dossier[$a])" $a}

}Until ($a -eq "STOP")

Write-Host "==================================================="
Write-Host "        "$rep[0] "bonne réponse"
Write-Host "        "$rep[1] "mauvaise réponse"
Write-Host "==================================================="
Read-Host