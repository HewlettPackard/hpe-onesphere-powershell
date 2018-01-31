# ns-api-ps
Powershell bindings for the OneSphere REST API

Import Module with: import-module hpeonesphere
List available commands with: get-command -module hpeonesphere

Check .\samples\hpeonesphere-tests.ps1 for the rest.

Use with .\samples\hpeonesphere-tests.ps1 -portal $YourOneSpherePortal -username $YourOneSphereUsername -password $YourOneSpherePassword -short

Please open Issues on repo for us to fix.

Thanks.

Current Status:

| Verb   	| Calls in API 	| Implemented in PS 	| % Implemented 	| % Tested 	| % Regression Test 	|
|--------	|--------------	|-------------------	|---------------	|----------	|-------------------	|
| GET    	| 51           	| 46                	| 90.20%        	| 84.31%   	| 74.51%            	|
| POST   	| 20           	| 16                	| 80.00%        	| 70.00%   	| 50.00%            	|
| DELETE 	| 15           	| 12                	| 80.00%        	| 66.67%   	| 60.00%            	|
| PATCH  	| 11           	| 1                 	| 9.09%         	| 9.09%    	| 9.09%             	|
| Total  	| 97           	| 75                	| 77.32%        	| 70.10%   	| 59.79%            	|


Details of individual calls:

| Verb   	| API URI                                 	| Implemented in API 	| Implemented in PowerShell 	| Full Parameter Set 	| Tested against StackBeta 	| Tested Against V1.0 	| Regression Test Program? 	|
|--------	|-----------------------------------------	|--------------------	|---------------------------	|--------------------	|--------------------------	|---------------------	|--------------------------	|
| GET    	| /rest/account                           	| NO                 	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/appliances                        	| YES                	| YES                       	| YES                	| NO                       	| NO                  	| NO                       	|
| POST   	| /rest/appliances                        	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/appliances/{id}                   	| YES                	| YES                       	| YES                	| NO                       	| NO                  	| NO                       	|
| PATCH  	| /rest/appliances/{id}                   	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/appliances/{id}                   	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/catalog-types                     	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/catalogs                          	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/catalogs                          	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/catalogs/{id}                     	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/catalogs/{id}                     	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| DELETE 	| /rest/catalogs/{id}                     	| YES                	| YES                       	| YES                	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/connect-app                       	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| NO                       	|
| GET    	| /rest/deployments                       	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/deployments                       	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| NO                       	|
| GET    	| /rest/deployments/{id}                  	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/deployments/{id}                  	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/deployments/{id}                  	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| NO                       	|
| POST   	| /rest/deployments/{id}/actions          	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| NO                       	|
| POST   	| /rest/deployments/{id}/console          	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/events                            	| NO                 	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/keypairs                          	| YES                	| YES                       	| YES                	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/membership-roles                  	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/memberships                       	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/memberships                       	| YES                	| YES                       	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/memberships                       	| YES                	| YES                       	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/metrics                           	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| NO                       	|
| GET    	| /rest/networks                          	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/networks/{id}                     	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/networs/{id}                      	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| POST   	| /rest/password-reset                    	| YES                	| YES                       	| YES                	| YES                      	| YES                 	| NO                       	|
| POST   	| /rest/password-reset/change             	| YES                	| YES                       	| YES                	| YES                      	| YES                 	| NO                       	|
| GET    	| /rest/projects                          	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/projects                          	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/projects/{id}                     	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/projects/{id}                     	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/projects/{id}                     	| YES                	| YES                       	| YES                	| YES                      	| YES                 	| YES                      	|
| GET    	| /rest/provider-types                    	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/providers                         	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/providers                         	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/providers/{id}                    	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/providers/{id}                    	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/providers/{id}                    	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/rates                             	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/rates/{id}                        	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| NO                       	|
| GET    	| /rest/regions                           	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/regions                           	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/regions/{id}                      	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/regions/{id}                      	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/regions/{id}                      	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/regions/{id}/connection           	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| POST   	| /rest/regions/{id}/connection           	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/regions/{id}/connection           	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/roles                             	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/service-types                     	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/service-types/{id}                	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/services                          	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/services/{id}                     	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/session                           	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/session                           	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| DELETE 	| /rest/session                           	| YES                	| YES                       	| YES                	| YES                      	| YES                 	| YES                      	|
| GET    	| /rest/session/idp                       	| NO                 	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/status                            	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/tag-keys                          	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/tag-keys                          	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/tag-keys/{id}                     	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| DELETE 	| /rest/tag-keys/{id}                     	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/tags                              	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/tags                              	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/tags/{id}                         	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| DELETE 	| /rest/tags/{id}                         	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/users                             	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/users                             	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/users/{id}                        	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/users/{id}                        	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/users/{id}                        	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/virtual-machine-profiles          	| YES                	| YES                       	| NO                 	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/virtual-machine-profiles/{id}     	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/volumes                           	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/volumes                           	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/volumes/{id}                      	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/volumes/{id}                      	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/volumes/{id}                      	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/zone-types                        	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/zone-types/{id}/resource-profiles 	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/zones                             	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/zones                             	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/zones/{id}                        	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| PATCH  	| /rest/zones/{id}                        	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/zones/{id}                        	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| POST   	| /rest/zones/{id}/actions                	| YES                	| YES                       	| YES                	| NO                       	| NO                  	| NO                       	|
| GET    	| /rest/zones/{id}/appliance-image        	| YES                	| YES                       	| YES                	| YES                      	| NO                  	| YES                      	|
| GET    	| /rest/zones/{id}/task-status            	| YES                	| YES                       	| YES                	| YES                      	| YES                 	| NO                       	|
| GET    	| /rest/zones/{id}/connections            	| YES                	| YES                       	| YES                	| YES                      	| YES                 	| NO                       	|
| POST   	| /rest/zones/{id}/connections            	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| PATCH  	| /rest/zones/{id}/connections/{id}       	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|
| DELETE 	| /rest/zones/{id}/connections/{id}       	| YES                	| NO                        	| NO                 	| NO                       	| NO                  	| NO                       	|