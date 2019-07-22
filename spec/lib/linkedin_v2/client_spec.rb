require "spec_helper"

describe LinkedinV2::Client do
  describe ".API" do
    let(:valid_token) { "token" }

    describe ".ORGANIZATIONS" do
      describe "#organizations" do
        context "with valid token", vcr: { cassette_name: "api/organizations" } do
          context "when projection is given" do
            context "but values is empty" do
              it "returns linkedin response default" do
                client = LinkedinV2::Client.new(token: valid_token)
                projection = ""
                expected_response = {
                  "elements" => [
                    {
                      "role" => "ADMINISTRATOR",
                      "roleAssignee" => a_value,
                      "state" => "APPROVED",
                      "organizationalTarget" => a_value,
                    },
                    {
                      "role" => "ADMINISTRATOR",
                      "roleAssignee" => a_value,
                      "state" => "APPROVED",
                      "organizationalTarget" => a_value
                    }
                  ],
                  "paging" => { "count" => 10, "start" => 0, "links" => [] }
                }

                result = client.organizations(projection: projection)

                expect(result).to match(expected_response)
              end
            end

            context "but value is a correct projection" do
              it "returns response limited by projection" do
                client = LinkedinV2::Client.new(token: valid_token)
                projection = "(elements*(organizationalTarget~(localizedName)))"
                expected_response = {
                  "elements" => [
                    {
                      "organizationalTarget~" =>
                      {
                        "localizedName" => a_value
                      },
                      "organizationalTarget" => a_value
                    },
                    {
                      "organizationalTarget~" => {
                        "localizedName" => a_value
                      },
                      "organizationalTarget" => a_value
                    }
                  ]
                }

                result = client.organizations(projection: projection)

                expect(result).to match(expected_response)
              end
            end

            context "but value is a incorrect projection" do
              context "when parameters are in an incorrect format" do
                it "raises LinkedinResponseError" do
                  client = LinkedinV2::Client.new(token: valid_token)
                  projection = "(incorrect query)"

                  expect {
                    client.organizations(projection: projection)
                  }.to raise_error(LinkedinV2::LinkedinResponseError)
                end
              end

              context "when attribute on query is wrong" do
                it "returns an empty hash" do
                  client = LinkedinV2::Client.new(token: valid_token)
                  # Note: elementsS
                  projection = "(elementsS*(organizationalTarget~(localizedName)))"
                  expected_response = {}

                  result = client.organizations(projection: projection)

                  expect(result).to eq(expected_response)
                end
              end
            end
          end

          context "when projection is not given" do
            it "returns linkedin response default" do
              client = LinkedinV2::Client.new(token: valid_token)
              expected_response = {
                "elements" => [
                  {
                    "role" => "ADMINISTRATOR",
                    "roleAssignee" => a_value,
                    "state" => "APPROVED",
                    "organizationalTarget" => a_value,
                  },
                  {
                    "role" => "ADMINISTRATOR",
                    "roleAssignee" => a_value,
                    "state" => "APPROVED",
                    "organizationalTarget" => a_value
                  }
                ],
                "paging" => { "count" => 10, "start" => 0, "links" => [] }
              }

              result = client.organizations

              expect(result).to match(expected_response)
            end
          end
        end

        context "with invalid token", vcr: { cassette_name: "api/invalid_token/organizations" } do
          it "raises LinkedinResponseError" do
            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.organizations
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end
      end

      describe "#company_brand" do
        context "with valid token", vcr: { cassette_name: "api/company_brand" } do
          context "when valid identifier" do
            context "when projection is given" do
              context "but values is empty" do
                it "returns linkedin response default" do
                  client = LinkedinV2::Client.new(token: valid_token)
                  projection = ""
                  expected_response = {
                    "description" => {
                      "localized" => {
                        "pt_BR" => a_value
                      }, "preferredLocale" => { "country" => a_value, "language" => a_value }
                    },
                    "alternativeNames" => a_value,
                    "specialties" => a_value,
                    "staffCountRange" => a_value,
                    "localizedSpecialties" => a_value,
                    "id" => a_value,
                    "localizedDescription" => a_value,
                    "localizedWebsite" => a_value,
                    "logoV2" => {
                      "original" => a_value,
                      "cropped" => a_value, "cropInfo" => { "x" => 0, "width" => 0, "y" => 0, "height" => 0 }
                    },
                    "vanityName" => a_value,
                    "website" => {
                      "localized" => {
                        "en_US" => a_value
                      },
                      "preferredLocale" => { "country" => a_value, "language" => a_value }
                    },
                    "localizedName" => a_value,
                    "groups" => a_value,
                    "versionTag" => a_value,
                    "defaultLocale" => { "country" => a_value, "language" => a_value },
                    "organizationType" => a_value,
                    "industries" => a_value,
                    "name" => {
                      "localized" => { "pt_BR" => a_value },
                      "preferredLocale" => { "country" => a_value, "language" => a_value }
                    },
                    "locations"=> [
                      {
                        "address" => {
                          "geographicArea" => a_value,
                          "country" => a_value,
                          "city" => a_value,
                          "postalCode" => a_value,
                          "line1" => a_value
                        },
                        "staffCountRange" => a_value,
                        "geoLocation" => a_value,
                        "locationType" => a_value
                      }
                    ],
                    "$URN" => a_value
                  }

                  result = client.company_brand(
                    identifier: "22302249",
                    projection: projection
                  )

                  expect(result).to match(expected_response)
                end
              end

              context "but value is a correct projection" do
                it "returns response limited by projection" do
                  client = LinkedinV2::Client.new(token: valid_token)
                  projection = "(id,vanityName)"
                  expected_response = {
                    "id" => a_value,
                    "vanityName" => "festapromoçõeseeventos"
                  }

                  result = client.company_brand(
                    identifier: "22302249",
                    projection: projection
                  )

                  expect(result).to match(expected_response)
                end
              end

              context "but value is a incorrect projection" do
                context "when parameters are in an incorrect format" do
                  it "raises LinkedinResponseError" do
                    client = LinkedinV2::Client.new(token: valid_token)
                    projection = "(incorrect query)"

                    expect {
                      client.company_brand(
                        identifier: "22302249",
                        projection: projection
                      )
                    }.to raise_error(LinkedinV2::LinkedinResponseError)
                  end
                end

                context "when attribute on query is wrong" do
                  it "returns an empty hash" do
                    client = LinkedinV2::Client.new(token: valid_token)
                    # Note: vanityNameE
                    projection = "(vanityNameE)"
                    expected_response = {}

                    result = client.company_brand(
                      identifier: "22302249",
                      projection: projection
                    )

                    expect(result).to eq(expected_response)
                  end
                end
              end
            end

            context "when projection is not given" do
              it "returns linkedin response default" do
                client = LinkedinV2::Client.new(token: valid_token)
                expected_response = {
                  "description" => {
                    "localized" => {
                      "pt_BR" => a_value
                    }, "preferredLocale" => { "country" => a_value, "language" => a_value }
                  },
                  "alternativeNames" => a_value,
                  "specialties" => a_value,
                  "staffCountRange" => a_value,
                  "localizedSpecialties" => a_value,
                  "id" => a_value,
                  "localizedDescription" => a_value,
                  "localizedWebsite" => a_value,
                  "logoV2" => {
                    "original" => a_value,
                    "cropped" => a_value, "cropInfo" => { "x" => 0, "width" => 0, "y" => 0, "height" => 0 }
                  },
                  "vanityName" => a_value,
                  "website" => {
                    "localized" => {
                      "en_US" => a_value
                    },
                    "preferredLocale" => { "country" => a_value, "language" => a_value }
                  },
                  "localizedName" => a_value,
                  "groups" => a_value,
                  "versionTag" => a_value,
                  "defaultLocale" => { "country" => a_value, "language" => a_value },
                  "organizationType" => a_value,
                  "industries" => a_value,
                  "name" => {
                    "localized" => { "pt_BR" => a_value },
                    "preferredLocale" => { "country" => a_value, "language" => a_value }
                  },
                  "locations"=> [
                    {
                      "address" => {
                        "geographicArea" => a_value,
                        "country" => a_value,
                        "city" => a_value,
                        "postalCode" => a_value,
                        "line1" => a_value
                      },
                      "staffCountRange" => a_value,
                      "geoLocation" => a_value,
                      "locationType" => a_value
                    }
                  ],
                  "$URN" => a_value
                }

                result = client.company_brand(identifier: "22302249")

                expect(result).to match(expected_response)
              end
            end
          end
        end

        context "with invalid token", vcr: { cassette_name: "api/invalid_token/company_brand" } do
          it "raises LinkedinResponseError" do
            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.company_brand(identifier: "22302249")
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end

        context "with invalid identifier", vcr: { cassette_name: "api/invalid_identifier/company_brand" } do
          it "raises LinkedinResponseError" do
            client = LinkedinV2::Client.new(token: valid_token)

            expect {
              client.company_brand(identifier: "999999")
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end
      end

      describe "#add_company_share" do
        context "with valid token", vcr: { cassette_name: "api/add_company_share" } do
          context "when all required parameters are present" do
            it "successfully share on LinkedIn" do
              params = {
                identifier: "22302249",
                url: "https://rockcontent.com",
                thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
                text: "Example from test",
              }
              client = LinkedinV2::Client.new(token: valid_token)
              expected_response = {
                "owner" => a_value,
                "activity" => a_value,
                "edited" => a_value,
                "created" => { "actor" => a_value, "time" => a_value },
                "serviceProvider" => "API",
                "id" => a_value,
                "lastModified" => { "actor" => a_value, "time" => a_value},
                "text" => { "text" => "Example from test" },
                "distribution" => {
                  "linkedInDistributionTarget" => { "visibleToGuest" => true }
                },
                "content"=> {
                  "contentEntities" => [
                    {
                      "entityLocation" => "https://rockcontent.com",
                      "thumbnails" => [
                        {
                          "imageSpecificContent" => {},
                          "resolvedUrl" => "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg"
                        }
                      ]
                    }
                  ],
                 "shareMediaCategory" => "ARTICLE"
                }
              }

              result = client.add_company_share(params)

              expect(result).to match(expected_response)
            end
          end

          context "when at least one required parameter is not present" do
            context "when is the 'thumbnail' parameter" do
              it "successfully share on LinkedIn" do
                params = {
                  url: "https://rockcontent.com",
                  identifier: "22302249",
                  text: "Example from test",
                }
                expected_response = {
                  "owner" => a_value,
                  "activity" => a_value,
                  "edited" => a_value,
                  "created" => { "actor" => a_value, "time" => a_value },
                  "serviceProvider" => "API",
                  "id" => a_value,
                  "lastModified" => { "actor" => a_value, "time" => a_value},
                  "text" => { "text" => "Example from test" },
                  "distribution" => {
                    "linkedInDistributionTarget" => { "visibleToGuest" => true }
                  },
                  "content"=> {
                    "contentEntities" => [
                      {
                        "entityLocation" => "https://rockcontent.com",
                        "thumbnails" => [
                          {
                            "imageSpecificContent" => {},
                            "resolvedUrl" => "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg"
                          }
                        ]
                      }
                    ],
                    "shareMediaCategory" => "ARTICLE"
                  }
                }
                client = LinkedinV2::Client.new(token: valid_token)

                result = client.add_company_share(params)

                expect(result).to match(expected_response)
              end
            end

            context "when is the 'url' parameter" do
              it "raises KeyError" do
                params = {
                  identifier: "22302249",
                  thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
                  text: "Example from test",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_company_share(params)
                }.to raise_error(KeyError)
              end
            end

            context "when is the 'identifier' parameter" do
              it "raises KeyError" do
                params = {
                  url: "https://rockcontent.com",
                  thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
                  text: "Example from test",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_company_share(params)
                }.to raise_error(KeyError)
              end
            end

            context "when is the 'text' parameter" do
              it "raises KeyError" do
                params = {
                  identifier: "22302249",
                  url: "https://rockcontent.com",
                  thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_company_share(params)
                }.to raise_error(KeyError)
              end
            end
          end
        end

        context "with invalid token", vcr: { cassette_name: "api/invalid_token/add_company_share" } do
          it "raises LinkedinResponseError" do
            params = {
              identifier: "22302249",
              url: "https://www.rockcontent.com/blog",
              text: "Sample text",
              thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
            }

            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.add_company_share(params)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end

        context "with invalid identifier", vcr: { cassette_name: "api/invalid_identifier/add_company_share" } do
          it "raises LinkedinResponseError" do
            params = {
              identifier: "9999999",
              url: "https://www.rockcontent.com/blog",
              text: "Sample text",
              thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
            }

            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.add_company_share(params)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end
      end

      describe "#add_company_post" do
        context "with valid token", vcr: { cassette_name: "api/add_company_post" } do
          context "when all required parameters are present" do
            it "successfully share on LinkedIn" do
              params = {
                identifier: "22302249",
                text: "Example to post",
              }
              client = LinkedinV2::Client.new(token: valid_token)
              expected_response = { "id" => a_value }

              result = client.add_company_post(params)

              expect(result).to match(expected_response)
            end
          end

          context "when at least one required parameter is not present" do
            context "when is the 'identifier' parameter" do
              it "raises KeyError" do
                params = {
                  text: "Example to post again!",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_company_post(params)
                }.to raise_error(KeyError)
              end
            end

            context "when is the 'text' parameter" do
              it "raises KeyError" do
                params = {
                  identifier: "22302249",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_company_post(params)
                }.to raise_error(KeyError)
              end
            end
          end
        end

        context "with invalid identifier", vcr: { cassette_name: "api/invalid_identifier/add_company_post" } do
          it "raises LinkedinResponseError" do
            params = {
              identifier: "9999999",
              text: "Sample text - again!",
            }

            client = LinkedinV2::Client.new(token: valid_token)

            expect {
              client.add_company_post(params)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end

        context "with invalid token", vcr: { cassette_name: "api/invalid_token/add_company_post" } do
          it "raises LinkedinResponseError" do
            params = {
              identifier: "22302249",
              text: "Sample text",
            }

            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.add_company_post(params)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end
      end
    end

    describe ".PROFILES" do
      describe "#me" do
        context "with valid token", vcr: { cassette_name: "api/me" } do
          context "when projection is given" do
            context "but values is empty" do
              it "returns linkedin response default" do
                client = LinkedinV2::Client.new(token: valid_token)
                projection = ""
                expected_response = {
                  "localizedLastName" => a_value,
                  "lastName" => {
                    "localized" => { "pt_BR" => a_value },
                    "preferredLocale" => { "country" => a_value, "language" => a_value }},
                  "vanityName" => a_value,
                  "localizedHeadline" => a_value,
                  "firstName" => {
                    "localized" => {
                      "pt_BR" => a_value
                    },
                    "preferredLocale" => { "country" => a_value, "language" => a_value }},
                  "profilePicture" => { "displayImage" => a_value },
                  "id" => a_value,
                  "headline" => {
                    "localized" => {
                      "pt_BR" => a_value
                    },
                    "preferredLocale" => { "country" => a_value, "language" => a_value }},
                  "localizedFirstName" => a_value
                }

                result = client.me(projection: projection)

                expect(result).to match(expected_response)
              end
            end

            context "but value is a correct projection" do
              it "returns response limited by projection" do
                client = LinkedinV2::Client.new(token: valid_token)
                projection = "(localizedFirstName)"
                expected_response = { "localizedFirstName" => a_value }

                result = client.me(projection: projection)

                expect(result).to match(expected_response)
              end
            end

            context "but value is a incorrect projection" do
              context "when parameters are in an incorrect format" do
                it "raises LinkedinResponseError" do
                  client = LinkedinV2::Client.new(token: valid_token)
                  projection = "(incorrect query)"

                  expect {
                    client.me(projection: projection)
                  }.to raise_error(LinkedinV2::LinkedinResponseError)
                end
              end

              context "when attribute on query is wrong" do
                it "returns an empty hash" do
                  client = LinkedinV2::Client.new(token: valid_token)
                  # Note: localizedFirstNameE
                  projection = "(localizedFirstNameE)"
                  expected_response = {}

                  result = client.me(projection: projection)

                  expect(result).to eq(expected_response)
                end
              end
            end
          end

          context "when projection is not given" do
            it "returns linkedin response default" do
              client = LinkedinV2::Client.new(token: valid_token)
              expected_response = {
                "localizedLastName" => a_value,
                "lastName" => {
                  "localized" => { "pt_BR" => a_value },
                  "preferredLocale" => { "country" => a_value, "language" => a_value }},
                "vanityName" => a_value,
                "localizedHeadline" => a_value,
                "firstName" => {
                  "localized" => {
                    "pt_BR" => a_value
                  },
                  "preferredLocale" => { "country" => a_value, "language" => a_value }},
                "profilePicture" => { "displayImage" => a_value },
                "id" => a_value,
                "headline" => {
                  "localized" => {
                    "pt_BR" => a_value
                  },
                  "preferredLocale" => { "country" => a_value, "language" => a_value }},
                "localizedFirstName" => a_value
              }

              result = client.me

              expect(result).to match(expected_response)
            end
          end
        end

        context "with invalid token", vcr: { cassette_name: "api/invalid_token/me" } do
          it "raises LinkedinResponseError" do
            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.organizations
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end
      end

      describe "#add_profile_share" do
        context "with valid token", vcr: { cassette_name: "api/add_profile_share" } do
          context "when all required parameters are present" do
            it "successfully share on LinkedIn" do
              params = {
                identifier: "zdUs3lzI6l",
                url: "https://rockcontent.com",
                thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
                text: "Example from test",
              }
              client = LinkedinV2::Client.new(token: valid_token)
              expected_response = {
                "owner" => a_value,
                "activity" => a_value,
                "edited" => a_value,
                "created" => { "actor" => a_value, "time" => a_value },
                "serviceProvider" => "API",
                "id" => a_value,
                "lastModified" => { "actor" => a_value, "time" => a_value},
                "text" => { "text" => "Example from test" },
                "distribution" => {
                  "linkedInDistributionTarget" => { "visibleToGuest" => true }
                },
                "content"=> {
                  "contentEntities" => [
                    {
                      "entityLocation" => "https://rockcontent.com",
                      "thumbnails" => [
                        {
                          "imageSpecificContent" => {},
                          "resolvedUrl" => "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg"
                        }
                      ]
                    }
                  ],
                 "shareMediaCategory" => "ARTICLE"
                }
              }

              result = client.add_profile_share(params)

              expect(result).to match(expected_response)
            end
          end

          context "when at least one required parameter is not present" do
            context "when is the 'thumbnail' parameter" do
              it "successfully share on LinkedIn" do
                params = {
                  url: "https://rockcontent.com",
                  identifier: "zdUs3lzI6l",
                  text: "Example from test",
                }
                expected_response = {
                  "owner" => a_value,
                  "activity" => a_value,
                  "edited" => a_value,
                  "created" => { "actor" => a_value, "time" => a_value },
                  "serviceProvider" => "API",
                  "id" => a_value,
                  "lastModified" => { "actor" => a_value, "time" => a_value},
                  "text" => { "text" => "Example from test" },
                  "distribution" => {
                    "linkedInDistributionTarget" => { "visibleToGuest" => true }
                  },
                  "content"=> {
                    "contentEntities" => [
                      {
                        "entityLocation" => "https://rockcontent.com",
                        "thumbnails" => [
                          {
                            "imageSpecificContent" => {},
                            "resolvedUrl" => "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg"
                          }
                        ]
                      }
                    ],
                    "shareMediaCategory" => "ARTICLE"
                  }
                }
                client = LinkedinV2::Client.new(token: valid_token)

                result = client.add_profile_share(params)

                expect(result).to match(expected_response)
              end
            end

            context "when is the 'url' parameter" do
              it "raises KeyError" do
                params = {
                  identifier: "zdUs3lzI6l",
                  thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
                  text: "Example from test",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_profile_share(params)
                }.to raise_error(KeyError)
              end
            end

            context "when is the 'identifier' parameter" do
              it "raises KeyError" do
                params = {
                  url: "https://rockcontent.com",
                  thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
                  text: "Example from test",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_profile_share(params)
                }.to raise_error(KeyError)
              end
            end

            context "when is the 'text' parameter" do
              it "raises KeyError" do
                params = {
                  identifier: "zdUs3lzI6l",
                  url: "https://rockcontent.com",
                  thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_profile_share(params)
                }.to raise_error(KeyError)
              end
            end
          end
        end

        context "with invalid token", vcr: { cassette_name: "api/invalid_token/add_profile_share" } do
          it "raises LinkedinResponseError" do
            params = {
              identifier: "zdUs3lzI6l",
              url: "https://www.rockcontent.com/blog",
              text: "Sample text",
              thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
            }

            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.add_profile_share(params)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end

        context "with invalid identifier", vcr: { cassette_name: "api/invalid_identifier/add_profile_share" } do
          it "raises LinkedinResponseError" do
            params = {
              identifier: "9999999",
              url: "https://www.rockcontent.com/blog",
              text: "Sample text",
              thumbnail: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
            }

            client = LinkedinV2::Client.new(token: valid_token)

            expect {
              client.add_company_share(params)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end
      end

      describe "#add_profile_post" do
        context "with valid token", vcr: { cassette_name: "api/add_profile_post" } do
          context "when all required parameters are present" do
            it "successfully share on LinkedIn" do
              params = {
                identifier: "zdUs3lzI6l",
                text: "Example to post",
              }
              client = LinkedinV2::Client.new(token: valid_token)
              expected_response = { "id" => a_value }

              result = client.add_profile_post(params)

              expect(result).to match(expected_response)
            end
          end

          context "when at least one required parameter is not present" do
            context "when is the 'identifier' parameter" do
              it "raises KeyError" do
                params = {
                  text: "Example to post again!",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_profile_post(params)
                }.to raise_error(KeyError)
              end
            end

            context "when is the 'text' parameter" do
              it "raises KeyError" do
                params = {
                  identifier: "zdUs3lzI6l",
                }

                client = LinkedinV2::Client.new(token: valid_token)

                expect {
                  client.add_profile_post(params)
                }.to raise_error(KeyError)
              end
            end
          end
        end

        context "with invalid identifier", vcr: { cassette_name: "api/invalid_identifier/add_profile_post" } do
          it "raises LinkedinResponseError" do
            params = {
              identifier: "9999999",
              text: "Sample text - again!",
            }

            client = LinkedinV2::Client.new(token: valid_token)

            expect {
              client.add_profile_post(params)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end

        context "with invalid token", vcr: { cassette_name: "api/invalid_token/add_profile_post" } do
          it "raises LinkedinResponseError" do
            params = {
              identifier: "zdUs3lzI6l",
              text: "Sample text",
            }

            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.add_profile_post(params)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end
      end
    end

    describe ".MEDIAS" do
      describe "#upload_image" do
        context "with valid token", vcr: { cassette_name: "api/medias" } do
          it "returns linkedin response default" do
            client = LinkedinV2::Client.new(token: valid_token)
            picture_url = "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg"
            expected_response = {
              "location" => "urn:li:richMediaSummary:JPEG-IMG-6b274eb0149c4af69b2b44ca13ee4be9"
            }

            result = client.upload_image(picture_url: picture_url)

            expect(result).to match(expected_response)
          end
        end

        context "with invalid token", vcr: { cassette_name: "api/invalid_token/medias" } do
          it "returns linkedin response default" do
            client = LinkedinV2::Client.new(token: valid_token)
            picture_url = "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg"

            client = LinkedinV2::Client.new(token: "invalid_token")

            expect {
              client.upload_image(picture_url: picture_url)
            }.to raise_error(LinkedinV2::LinkedinResponseError)
          end
        end
      end
    end
  end
end
