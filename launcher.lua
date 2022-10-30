local function instance(className,properties,children,funcs) local object = Instance.new(className,parent);for i,v in pairs(properties or {}) do object[i] = v;end;for i, self in pairs(children or {}) do self.Parent = object;end;for i,func in pairs(funcs or {}) do func(object);end;return object end
local function ts(object,tweenInfo,properties) if tweenInfo[2] and typeof(tweenInfo[2]) == 'string' then tweenInfo[2] = Enum.EasingStyle[ tweenInfo[2] ];end;game:service('TweenService'):create(object, TweenInfo.new(unpack(tweenInfo)), properties):Play();end
local function udim2(x1,x2,y1,y2) local t = tonumber;return UDim2.new(t(x1),t(x2),t(y1),t(y2)) end
local function rgb(r,g,b) return Color3.fromRGB(r,g,b);end


pcall(function()
    game:service('CoreGui')['6crimzL']:Destroy()
end)

local sgui = instance('ScreenGui', {
    Name = '6crimzL',
    Parent = game:service('CoreGui')
})

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

local verify, key2;

local mainFrame = instance('Frame', {
    Parent = sgui,
    Size = udim2(0, 0, 0, 110),
    Position = udim2(0.5, 0, 0.5, -110/2),
    BackgroundTransparency = 0.4,
    BackgroundColor3 = rgb(60, 50, 50)
}, {
    instance('UICorner', {
        CornerRadius = UDim.new(0, 8)
    }),
    instance('Frame', {
        Position = udim2(0, 10, 0, 10),
        Size = udim2(1, -20, 1, -20),
        Name = 'blur',
        BackgroundTransparency = 1,
    }),
    instance('TextLabel', {
        Text = 'Welcome to 6crimzz',
        Font = 'GothamMedium',
        TextSize = 13,
        BackgroundTransparency = 1,
        Size = udim2(1, 0, 0, 40),
        TextColor3 = rgb(255, 220, 220)
    }),
    instance('Frame', {
        Size = udim2(1, -32, 0, 30),
        Position = udim2(0, 16, 0.5, -15),
        BackgroundColor3 = rgb(0, 0, 0),
        BackgroundTransparency = 0.6,
    }, {
        instance('UICorner', {
            CornerRadius = UDim.new(0, 5)
        }),
        instance('TextBox', {
            Text = '',
            PlaceholderText = 'Insert your key here',
            PlaceholderColor3 = rgb(180, 160, 160),
            TextColor3 = rgb(255, 220, 220),
            Position = udim2(0, 8, 0, 0),
            Size = udim2(1, -16, 1, 0),
            Font = 'Gotham',
            TextSize = 13,
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            TextXAlignment = 'Left'
        }, {}, {
            function(self)
                self.FocusLost:Connect(function()
                    key2 = self.Text
                end)
            end
        })
    }),
    instance('Frame', {
        Size = udim2(1, 0, 0, 40),
        Position = udim2(0, 0, 0, 70),
        BackgroundTransparency = 1
    }, {
        instance('Frame', {
            Size = udim2(0, 80, 0, 22),
            Position = udim2(0.5, -40, 0.5, -11),
            BackgroundColor3 = rgb(150, 255, 150),
        }, {
            instance('UICorner', {
                CornerRadius = UDim.new(0, 5)
            }),
            instance('TextButton', {
                Text = 'LOGIN',
                TextSize = 12,
                TextColor3 = rgb(0, 0, 0),
                Font = 'GothamBold',
                BackgroundTransparency = 1,
                Size = udim2(1, 0, 1, 0)
            }, {}, {
                function(self)
                    self.MouseButton1Down:Connect(function()
                        local attempt = verify(key2)
                        if attempt then
                            sgui:Destroy()
                        end
                    end)
                end
            }),
            instance('UIGradient', {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, rgb(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, rgb(190, 190, 190))
                }),
                Rotation = 17
            })
        })
    })
})

verify = function(key)
    if string.len(key) ~= 40 then
        return false
    end

    _G.wl_key = key

    spawn(function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/6crimzz/6crimzz/main/launcher.lua"), true))()
    end)
    
    return true
end


blurModule:BindFrame(mainFrame.blur, {
    Transparency = 0.999,
    Material = 'Glass',
    Color = rgb(255, 255, 255)
})

ts(mainFrame, {0.3, 'Exponential'}, {
    Size = udim2(0, 230, 0, 110),
    Position = udim2(0.5, -230/2, 0.5, -110/2)
})
