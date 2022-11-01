local crimz = {}

function crimz:Create()
    local funcTbl = {}

    local function instance(className,properties,children,funcs) local object = Instance.new(className,parent);for i,v in pairs(properties or {}) do object[i] = v;end;for i, self in pairs(children or {}) do self.Parent = object;end;for i,func in pairs(funcs or {}) do func(object);end;return object end
    local function ts(object,tweenInfo,properties) if tweenInfo[2] and typeof(tweenInfo[2]) == 'string' then tweenInfo[2] = Enum.EasingStyle[ tweenInfo[2] ];end;game:service('TweenService'):create(object, TweenInfo.new(unpack(tweenInfo)), properties):Play();end
    local function udim2(x1,x2,y1,y2) local t = tonumber;return UDim2.new(t(x1),t(x2),t(y1),t(y2)) end
    local function rgb(r,g,b) return Color3.fromRGB(r,g,b);end

    local mouse = game:service('Players').LocalPlayer:GetMouse()

    local function checkPos(obj)
        local x, y = mouse.X, mouse.Y
        local abs, abp = obj.AbsoluteSize, obj.AbsolutePosition
    
        if x > abp.X and x < (abp.X + abs.X) and y > abp.Y and y < (abp.Y + abs.Y) then
            return true
        end
        return nil
    end

    local function getRel(object)
        return {
            X = (mouse.X - object.AbsolutePosition.X),
            Y = (mouse.Y - object.AbsolutePosition.Y)
        }
    end

    if not isfile('6crimzz-key.txt') then
        writefile('6crimzz-key.txt', '')
    end

    if typeof(_G.wl_key) == 'string' then
        if readfile('6crimzz-key.txt') ~= _G.wl_key then
            writefile('6crimzz-key.txt', _G.wl_key)
        end
    end
        
    local mouse = game:service('Players').LocalPlayer:GetMouse()
    
    local function dragify(frame) 
        local connection, move, kill
        local function connect()
            connection = frame.InputBegan:Connect(function(inp) 
                pcall(function() 
                    if (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) then 
                        local mx, my = mouse.X, mouse.Y 
                        move = mouse.Move:Connect(function() 
                            local nmx, nmy = mouse.X, mouse.Y 
                            local dx, dy = nmx - mx, nmy - my 
                            frame.Position = frame.Position + UDim2.fromOffset(dx, dy)
                            mx, my = nmx, nmy 
                        end) 
                        kill = frame.InputEnded:Connect(function(inputType) 
                            if inputType.UserInputType == Enum.UserInputType.MouseButton1 then 
                                move:Disconnect() 
                                kill:Disconnect() 
                            end 
                        end) 
                    end 
                end) 
            end) 
        end
        connect()
        return {
            disconnect = function()
                connection:Disconnect()
            end,
            reconnect = connect,
            killConnection = function()
                move:Disconnect()
                kill:Disconnect()
            end
        }
    end
    
    local function makeBetter(obj)
        local drag = dragify(obj)
    
        local button = instance('TextButton', {
            Parent = obj,
            Size = udim2(0, 10, 0, 10),
            BackgroundTransparency = 1,
            Text = '',
            Position = udim2(1, -10, 1, -10)
        })
    
        local holding = false
        button.MouseButton1Down:Connect(function()
            holding = true
            drag.disconnect()
    
            spawn(function()
                repeat
                    local sX, sY = (getRel(obj).X - obj.AbsoluteSize.X), (getRel(obj).Y - obj.AbsoluteSize.Y)
                    wait()
                    ts(obj, {0.5, 'Exponential'}, {
                        Size = udim2(0, obj.AbsoluteSize.X + sX, 0, obj.AbsoluteSize.Y + sY)
                    })
                until not holding
            end)
        end)
    
        local function unhold()
            if holding then
                holding = false
                drag.reconnect()
            end
        end
    
        button.MouseButton1Up:Connect(unhold)
        mouse.Button1Up:Connect(unhold)
    end

    if not blurModule then
        getgenv().blurModule = loadstring(syn.request({Url = 'https://raw.githubusercontent.com/boop71/cappuccino-new/main/utilities/blurModule.lua', Method = 'GET'}).Body)()
    end

    if not game:service('Lighting'):FindFirstChild('cap_blur') then
        instance('DepthOfFieldEffect', {
            Parent = game:service('Lighting'),
            FarIntensity = 0,
            Name = 'cap_blur',
            FocusDistance = 51.5,
            InFocusRadius = 50,
            NearIntensity = 1,
            Enabled = true
        })
    end

    pcall(function()
        game:service('CoreGui')['6crimzz']:Destroy()
    end)

    local sgui = instance('ScreenGui', {
        Name = '6crimzz',
        Parent = game:service('CoreGui')
    })
    local mainFrame

    local toggled, savedPos = true, udim2(0, 0, 0, 0)
    game:service('UserInputService').InputBegan:Connect(function(k, t)
        if t then
            return
        end
        
        if k.KeyCode == Enum.KeyCode.RightShift then
            toggled = not toggled
            if not toggled then
                savedPos = mainFrame.Position
                mainFrame.Position = udim2(-1, 0, -1, 0)
            else
                mainFrame.Position = savedPos
            end
        end
    end)

    mainFrame = instance('Frame', {
        Parent = sgui,
        Name = 'body',
        Size = udim2(0, 327, 0, 280),
        Position = udim2(0.5, -327/2, 0.5, -280/2),
        BackgroundTransparency = 0.2,
        BackgroundColor3 = rgb(30, 30, 30)
    }, {
        instance('Frame', {
            Position = udim2(0, 12, 0, 12),
            Size = udim2(1, -24, 1, -24),
            BackgroundTransparency = 1,
            Name = 'blur'
        }),
        instance('UICorner', {
            CornerRadius = UDim.new(0, 8)
        }),
        instance('Frame', {
            Name = 'topBar',
            Size = udim2(1, 0, 0, 30),
            BackgroundColor3 = rgb(60, 50, 50),
        }, {
            instance('UICorner', {
                CornerRadius = UDim.new(0, 8)
            }),
            instance('Frame', {
                Size = udim2(1, 0, 0, 8),
                Position = udim2(0, 0, 1, -8),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(60, 50, 50)
            }),
            instance('ImageLabel', {
                Size = udim2(0, 20, 0, 20),
                Position = udim2(0, 5, 0, 5),
                BackgroundTransparency = 1,
                Image = 'rbxassetid://11374109116'
            }, {
                instance('UICorner', {
                    CornerRadius = UDim.new(1, 0)
                }),
                instance('TextLabel', {
                    Position = udim2(1, 6, 0, 0),
                    Size = udim2(0, 58, 0, 20),
                    Text = '6crimzz',
                    Font = 'GothamBold',
                    TextColor3 = rgb(255, 255, 255),
                    TextXAlignment = 'Left',
                    TextSize = 14,
                    BackgroundTransparency = 1,
                }, {
                    instance('TextLabel', {
                        Position = udim2(1, 0, 0, 0),
                        Text = '| script hub',
                        BackgroundTransparency = 1,
                        TextXAlignment = 'Left',
                        TextColor3 = rgb(255, 255, 255),
                        Font = 'Gotham',
                        TextSize = 14,
                        Size = udim2(0, 61, 0, 20)
                    })
                })
            })
        }),
        instance('Frame', {
            Name = 'bottomBar',
            Size = udim2(1, 0, 0, 30),
            Position = udim2(0, 0, 1, -30),
            BackgroundColor3 = rgb(60, 50, 50),
        }, {
            instance('UICorner', {
                CornerRadius = UDim.new(0, 8)
            }),
            instance('Frame', {
                Size = udim2(1, 0, 0, 8),
                BackgroundColor3 = rgb(60, 50, 50),
                BorderSizePixel = 0
            }),
            instance('TextLabel', {
                Size = udim2(1, -10, 1, 0),
                Position = udim2(0, 10, 0, 0),
                Text = 'discord.gg/6crimzz',
                Font = 'GothamBold',
                TextSize = 13, 
                BackgroundTransparency = 1,
                TextColor3 = rgb(255, 220, 220),
                TextXAlignment = 'Left'
            }),
            instance('TextLabel', {
                Size = udim2(1, -10, 1, 0),
                TextXAlignment = 'Right',
                Text = 'Press RightShift to toggle this GUI',
                Font = 'Gotham',
                TextSize = 11,
                BackgroundTransparency = 1,
                TextColor3 = rgb(200, 180, 180)
            })
        }),
        instance('Frame', {
            Name = 'body',
            Position = udim2(0, 4, 0, 34),
            Size = udim2(1, -8, 1, -68),
            BackgroundTransparency = 0.7,
            BackgroundColor3 = rgb(0, 0, 0)
        }, {
            instance('UICorner', {
                CornerRadius = UDim.new(0, 8)
            }),
            instance('ScrollingFrame', {
                Position = udim2(0, 4, 0, 4),
                Size = udim2(1, -8, 1, -8),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ScrollBarImageColor3 = rgb(150, 100, 100),
                ScrollBarThickness = 2,
            }, {
                instance('UIGridLayout', {
                    CellPadding = udim2(0, 5, 0, 5),
                    CellSize = udim2(0, 150, 0, 100),
                })
            })
        })
    })

    makeBetter(mainFrame)

    blurModule:BindFrame(mainFrame.blur, {
        Transparency = 0.999,
        Material = 'Glass',
        Color = rgb(255, 255, 255)
    })

    function funcTbl:Script(data)
        data.Name = typeof(data.Name) == 'string' and data.Name or '[Empty Script Name]'
        data.Image = typeof(data.Image) == 'string' and data.Image or '11385430185'
        data.Short_Description = typeof(data.Short_Description) == 'string' and data.Short_Description or '[Empty Description]'
        data.Long_Description = typeof(data.Long_Description) == 'string' and data.Long_Description or '[Empty Long Description]'
        data.Script = typeof(data.Script) == 'function' and data.Script or function() end

        local toggle, toggled, cooldown = nil, false, false

        local scriptBody = instance('Frame', {
            Parent = sgui,
            Size = udim2(0, 0, 0, 200),
            Position = udim2(0, 0, 0, -200),
            BackgroundTransparency = 0.3,
            BackgroundColor3 = rgb(0, 0, 0),
            BorderSizePixel = 0,
            ClipsDescendants = true
        }, {
            instance('Frame', {
                Name = 'blur',
                Position = udim2(0, 10, 0, 10),
                Size = udim2(1, -20, 1, -20),
                BackgroundTransparency = 1,
            }),
            instance('UICorner', {
                CornerRadius = UDim.new(0, 8)
            }),
            instance('Frame', {
                Name = 'topBar',
                Size = udim2(1, 0, 0, 30),
                BackgroundColor3 = rgb(60, 50, 50),
            }, {
                instance('UICorner', {
                    CornerRadius = UDim.new(0, 8)
                }),
                instance('Frame', {
                    Size = udim2(1, 0, 0, 8),
                    Position = udim2(0, 0, 1, -8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(60, 50, 50)
                }),
                instance('TextLabel', {
                    Text = data.Name,
                    TextSize = 14,
                    Font = 'GothamBold',
                    BackgroundTransparency = 1,
                    Size = udim2(1, 0, 1, 0),
                    TextColor3 = rgb(255, 230, 230)
                })
            }),
            instance('TextLabel', {
                Size = udim2(1, -20, 1, -79),
                Position = udim2(0, 10, 0, 40),
                BackgroundTransparency = 1,
                TextSize = 14,
                Font = 'Gotham',
                TextColor3 = rgb(220, 220, 220),
                Text = data.Long_Description,
                TextXAlignment = 'Left',
                TextYAlignment = 'Top',
                TextWrapped = true,
            }),
            instance('Frame', {
                Size = udim2(1, -42, 0, 24),
                Position = udim2(0, 6, 1, -30),
                BackgroundTransparency = 0.4,
                BackgroundColor3 = rgb(210, 210, 210)
            }, {
                instance('UICorner', {
                    CornerRadius = UDim.new(0, 5)
                }),
                instance('UIGradient', {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, rgb(255, 255, 255)),
                        ColorSequenceKeypoint.new(1, rgb(190, 190, 190))
                    }),
                    Rotation = 11
                }),
                instance('TextButton', {
                    Text = 'EXECUTE',
                    TextSize = 13,
                    Font = 'Gotham',
                    TextColor3 = rgb(0, 0, 0),
                    BackgroundTransparency = 1,
                    Size = udim2(1, 0, 1, 0),
                }, {}, {
                    function(self)
                        self.MouseEnter:Connect(function()
                            self.Font = 'GothamBold'
                            ts(self.Parent, {0.3, 'Exponential'}, {
                                BackgroundColor3 = rgb(150, 255, 150)
                            })
                        end)

                        self.MouseLeave:Connect(function()
                            self.Font = 'Gotham'
                            ts(self.Parent, {0.3, 'Exponential'}, {
                                BackgroundColor3 = rgb(210, 210, 210)
                            })
                        end)

                        self.MouseButton1Down:Connect(function()
                            spawn(function()
                                pcall(function()
                                    data.Script()
                                end)
                            end)

                            self.Text = 'EXECUTED!'
                            ts(self.Parent, {0.3, 'Exponential'}, {
                                BackgroundColor3 = rgb(255, 255, 150)
                            })

                            delay(0.7, function()
                                self.Text = 'EXECUTE'
                                ts(self.Parent, {0.3, 'Exponential'}, {
                                    BackgroundColor3 = checkPos(self.Parent) and rgb(150, 255, 150) or rgb(210, 210, 210)
                                })
                            end)
                        end)
                    end
                }),
                instance('Frame', {
                    Size = udim2(0, 24, 0, 24),
                    Position = udim2(1, 6, 0, 0),
                    BackgroundColor3 = rgb(210, 210, 210),
                    BackgroundTransparency = 0.4
                }, {
                    instance('UICorner', {
                        CornerRadius = UDim.new(0, 5)
                    }),
                    instance('UIGradient', {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, rgb(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, rgb(190, 190, 190))
                        }),
                        Rotation = 11
                    }),
                    instance('TextButton', {
                        Text = 'X',
                        TextSize = 13,
                        Font = 'Gotham',
                        TextColor3 = rgb(0, 0, 0),
                        BackgroundTransparency = 1,
                        Size = udim2(1, 0, 1, 0),
                        ClipsDescendants = true
                    }, {}, {
                        function(self)
                            self.MouseEnter:Connect(function()
                                ts(self.Parent.Parent, {0.3, 'Exponential'}, {
                                    Size = udim2(1, -82, 0, 24),
                                })
                                ts(self.Parent, {0.3, 'Exponential'}, {
                                    Size = udim2(0, 64, 0, 24)
                                })

                                self.Font = 'GothamBold'
                                self.Text = 'Close'
                                ts(self.Parent, {0.3, 'Exponential'}, {
                                    BackgroundColor3 = rgb(255, 150, 150)
                                })
                            end)
    
                            self.MouseLeave:Connect(function()
                                ts(self.Parent.Parent, {0.3, 'Exponential'}, {
                                    Size = udim2(1, -42, 0, 24)
                                })
                                ts(self.Parent, {0.3, 'Exponential'}, {
                                    Size = udim2(0, 24, 0, 24)
                                })

                                self.Font = 'Gotham'
                                self.Text = 'X'
                                ts(self.Parent, {0.3, 'Exponential'}, {
                                    BackgroundColor3 = rgb(210, 210, 210)
                                })
                            end)

                            self.MouseButton1Down:Connect(function()
                                if cooldown then return end
                                toggled = not toggled; toggle(toggled)
                            end)
                        end
                    }),
                })
            })
        })

        blurModule:BindFrame(scriptBody.blur, {
            Transparency = 0.999,
            Material = 'Glass',
            Color = rgb(255, 255, 255)
        })

        dragify(scriptBody)

        local scriptCell = instance('Frame', {
            BackgroundColor3 = rgb(60, 50, 50),
            BackgroundTransparency = 0.4
        }, {
            instance('UICorner', {
                CornerRadius = UDim.new(0, 6)
            }),
            instance('Frame', {
                Size = udim2(0, 40, 0, 40),
                Position = udim2(0, 8, 0, 8),
                BackgroundColor3 = rgb(0, 0, 0),
                BackgroundTransparency = 0.5
            }, {
                instance('UICorner', {
                    CornerRadius = UDim.new(0, 4)
                }),
                instance('ImageLabel', {
                    BackgroundTransparency = 1,
                    Image = 'rbxassetid://' .. data.Image,
                    Position = udim2(0, 2, 0, 2),
                    Size = udim2(1, -4, 1, -4),
                }, {
                    instance('UICorner', {
                        CornerRadius = UDim.new(0, 3)
                    })
                }),
                instance('TextLabel', {
                    Size = udim2(0, 90, 0, 30),
                    Position = udim2(0, 46, 0, 5),
                    BackgroundTransparency = 1,
                    Text = data.Name,
                    TextColor3 = rgb(255, 255, 255),
                    Font = 'GothamMedium',
                    TextWrapped = true,
                    ClipsDescendants = true,
                    TextSize = 14,
                    TextXAlignment = 'Left'
                })
            }),
            instance('TextLabel', {
                Text = data.Short_Description,
                TextSize = 12,
                Font = 'Gotham',
                TextColor3 = rgb(200, 200, 200),
                BackgroundTransparency = 1,
                Size = udim2(1, -12, 0, 39),
                Position = udim2(0, 6, 0, 55),
                ClipsDescendants = true,
                TextXAlignment = 'Left',
                TextWrapped = true,
                TextYAlignment = 'Top'
            }),
            instance('TextButton', {
                Size = udim2(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = ''
            }, {}, {
                function(self)
                    self.MouseButton1Up:Connect(function()
                        if cooldown then return end
                        toggled = not toggled; toggle(toggled)
                    end)
                end
            })
        })

        toggle = function(s)
            if cooldown then
                return
            end
            cooldown = true
            delay(0.32, function()
                cooldown = false
            end)
            
            if s then
                scriptBody.Position = udim2(0.5, 0, 0.5, -200/2),
                ts(scriptBody, {0.3, 'Exponential'}, {
                    Size = udim2(0, 250, 0, 200),
                    Position = udim2(0.5, -250/2, 0.5, -200/2)
                })
            else
                ts(scriptBody, {0.3, 'Exponential'}, {
                    Size = udim2(0, 0, 0, 200),
                    Position = udim2(0, scriptBody.AbsolutePosition.X + 125, 0, scriptBody.AbsolutePosition.Y)
                })
                delay(0.3, function()
                    scriptBody.Position = udim2(0, 0, 0, -200)
                end)
            end
        end

        scriptCell.Parent = mainFrame.body.ScrollingFrame
    end

    return funcTbl
end




local a = crimz:Create()

a:Script({
    Image = '11441330700',
    Name = 'DH streamable',
    Short_Description = '6crimzz on top',
    Long_Description = 'The lock keybind is "E", this script works on any DH game',
    Script = function()
        loadstring(game:HttpGet(("https://pastebin.com/raw/VXKZpP6L"), true))()
    end
})

a:Script({
    Image = '11441330700',
    Name = 'Another streamable',
    Short_Description = 'Mouse lock',
    Long_Description = 'The lock keybind is "E", this script works on any DH game',
    Script = function()
        loadstring(game:HttpGet(("https://pastebin.com/raw/waJRk8iT"), true))()
    end
})

a:Script({
    Image = '11441330700',
    Name = 'Streamable silent aim',
    Short_Description = 'This is a silent aimbot for DH streamable',
    Long_Description = 'This script does not have a keybind, it works automatically after launching it',
    Script = function()
        loadstring(game:HttpGet(("https://pastebin.com/raw/8X4SuRAG"), true))()
    end
})

a:Script({
    Image = '11441330700',
    Name = 'Universal FPS booster',
    Short_Description = 'Boosts your FPS',
    Long_Description = 'This script boosts your FPS in every game by making it look worse',
    Script = function()
        loadstring(game:HttpGet(("https://pastebin.com/raw/xZA18K77"), true))()
    end
})

a:Script({
    Image = '11441330700',
    Name = 'Anti Lock',
    Short_Description = 'People cant lock on to you',
    Long_Description = 'When executed people can not lock on to you. When pressing Z it makes it so people will shot at the ground but it also makes it so u cant jump. i recomend not pressing Z because as long as the script is executed people can not lock on to you no matter what',
    Script = function()
        local Toggled, KeyCode, hip, val = true, 'z', 2.80, -35
        function AA()
            local oldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity; game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z); game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z); game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z); game.Players.LocalPlayer.Character.Humanoid.HipHeight = hip
        end
        game:GetService('UserInputService').InputBegan:Connect(function(Key)
            if Key.KeyCode == Enum.KeyCode[KeyCode:upper()] and not game:GetService('UserInputService'):GetFocusedTextBox() then
                if Toggled then
                    Toggled = false
                    game.Players.LocalPlayer.Character.Humanoid.HipHeight = hip
                elseif not Toggled then
                    Toggled = true
                    while Toggled do
                        AA()
                        task.wait()
                    end
                end
            end
        end)
    end
})

