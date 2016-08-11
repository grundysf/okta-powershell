function Get-OktaUsersID()

{

    $user = $userid    
    $uri='https://company.okta.com/api/v1/users/'+$user;
    $headers = @{"Authorization"="SSWS apitokenenteredhere"}
    $return = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -ContentType "application/json"
    
    return $return.id

}


function Get-Okta2Factor($id)
{

    $id = Get-OktaUsersID
    $office365 = "0oaxqry8jYYMGTQBQEDK";
    $uri='https://company.okta.com/api/v1/users/' + $id + '/factors/catalog'
    $headers = @{"Authorization"="SSWS apitokenenteredhere"} 
    $return = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -ContentType "application/json"

    return $return

}

function Del-Okta2Factor($id) {

    $id = Get-OktaUsersID
    $uri='https://company.okta.com/api/v1/users/' + $id + '/factors/' + $fid
    $headers = @{"Authorization"="SSWS apitokenenteredhere"}
    $return = Invoke-RestMethod -Uri $uri -Method Delete -Headers $headers -ContentType "application/json"

}

function Get-OktaApp {

    $id = Get-OktaUsersID
    $uri='https://company.okta.com/api/v1/apps?filter=user.id+eq+' + """$id""" + '&expand=user/' + """$id"""
    $headers = @{"Authorization"="SSWS apitokenenteredhere"}
    $return = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -ContentType "application/json"

    $return

}

function Get-OktaMozyCreds {


    $id = Get-OktaUsersID
    $MozyAppid = "0oaqokc0uqBGHXSXYZZT"
    $uri='https://company.okta.com/api/v1/apps/' + $MozyAppid + '/users/' + $id
    $headers = @{"Authorization"="SSWS apitokenenteredhere"}
    $return = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -ContentType "application/json"

    $return

}

function Set-FactorType {

    $id = Get-OktaUsersID
    $uri='https://company.okta.com/api/v1/apps/users/' + $id + '/factors'
    $headers = @{"Authorization"="SSWS apitokenenteredhere"}
    
    $json =  '{
            "factorType": "token:software:totp",
            "provider": "OKTA"
    }'


    $return = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $json -ContentType "application/json"

try {
    
    $return

        } catch {

    $_.Exception.Message

    }

}

