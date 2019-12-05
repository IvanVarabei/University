import pygame
import random
from globalVars import *
from utils import *
from button import Button
from bullet import Bullet
from bird import Bird
pygame.init()

class Object:
    def __init__(self,x,y, width,image,speed):
        self.x=x
        self.y=y
        self.width=width
        self.image=image
        self.speed=speed
    def move(self):
        if self.x >= -self.width:
            display.blit(self.image,(self.x,self.y))           
            self.x-=self.speed
            return True
        else:
            return False
    def return_self(self,radius,y,width,image):
        self.x=radius
        self.y=y
        self.width=width
        self.image=image
        display.blit(self.image,(self.x,self.y))
           

def show_menu():
    menu_bckgr=pygame.image.load('Menu.jpg')
    start_btn=Button(288,70)
    quit_btn=Button(120,70)
    ruls_btn=Button(288,70)
    dvlpr_btn=Button(288,70)
    show=True
    while show:
        for event in pygame.event.get():
            if event.type==pygame.QUIT:
                pygame.quit()
                quit()
        display.blit(menu_bckgr,(0,0))
        dvlpr_btn.draw(270,100, 'Originator',show_orgntr,50)
        start_btn.draw(270,300, 'Start game',start_game,50)
        quit_btn.draw(358,400, 'quit',quit,50)
        start_btn.draw(270,200, 'Instruction',show_ruls,50)
        draw_mouse()
        pygame.display.update()
        clock.tick(30)
def start_game():
    global scores,make_jump,jump_counter,usr_y,health,cooldown
    while game_cycle():
        scores=0
        make_jump=False
        jump_counter=30
        usr_y=display_height-usr_height-100
        health=2
        cooldown=0
def show_ruls():
    rul_bckgr=pygame.image.load('rul_img.jpg')
    rulsReturn_btn=Button(288,70)
    stop=1
    while stop:
        for event in pygame.event.get():
            if event.type==pygame.QUIT:
                pygame.quit()
                quit()
        display.blit(rul_bckgr,(0,0))
        rulsReturn_btn.draw(270,500, '<<Backward',show_menu,50)
        draw_mouse()
        pygame.display.update()
        clock.tick(30)
def show_orgntr():
    rul_bckgr=pygame.image.load('orgntr_img.jpg')
    rulsReturn_btn=Button(288,70)
    stop=1
    while stop:
        for event in pygame.event.get():
            if event.type==pygame.QUIT:
                pygame.quit()
                quit()
        display.blit(rul_bckgr,(0,0))
        rulsReturn_btn.draw(270,500, '<<Backward',show_menu,50)
        draw_mouse()
        pygame.display.update()
        
        clock.tick(30)      

def game_cycle():
    global make_jump,cooldown
    pygame.mixer.music.play(-1)
    game=True
    cactus_arr=[]
    create_cactus_arr(cactus_arr)
    land=pygame.image.load(r'Land.jpg')
    stone,cloud=open_random_objects()
    heart= Object(display_width,330,30,health_img,4)
    all_btn_bullets=[]
    all_ms_bullets=[]
    bird1=Bird(-180)
    bird2=Bird(-140)
    all_birds=[bird1,bird2]
    while game:
        for event in pygame.event.get():
            if event.type==pygame.QUIT:
                pygame.quit()
                quit()

        keys=pygame.key.get_pressed()
        mouse=pygame.mouse.get_pos()
        click=pygame.mouse.get_pressed()
        if keys[pygame.K_SPACE]:
            make_jump=True
        
        count_scores(cactus_arr)
        display.blit(land,(0,0))
        print_text('Score : '+str(scores),10,40)
        draw_array(cactus_arr)
        move_objects(stone,cloud)
        drow_dino()
        
        if keys[pygame.K_ESCAPE]:
            pause()
        if not cooldown:
            if keys[pygame.K_x]:
                pygame.mixer.Sound.play(bullet_sound)
                all_btn_bullets.append(Bullet(usr_x+usr_width, usr_y+28))
                cooldown=50
            elif click[0]:
                pygame.mixer.Sound.play(bullet_sound)
                add_bullet=Bullet(usr_x+usr_width, usr_y+28)
                add_bullet.find_path(mouse[0],mouse[1])
                all_ms_bullets.append(add_bullet)
                cooldown=50
                
        else:
            print_text('Cooldown time : ' +str(cooldown//10),10,70)
            cooldown-=1
        for bullet in all_btn_bullets:
            if not bullet.move():
                all_btn_bullets.remove(bullet)
        for bullet in all_ms_bullets:
            if not bullet.move_to():
                all_ms_bullets.remove(bullet)
        heart.move()
        heart_plus(heart)
        if make_jump:
            jump()
        if check_collision(cactus_arr):
            game=False
        
        draw_birds(all_birds)
        check_birds_dmg(all_ms_bullets,all_birds)
        #
        if check_dino_damage(bird1.get_bullets()) or check_dino_damage(bird2.get_bullets()):
            game=False
        show_health()
        draw_mouse()
        pygame.display.update()
        if scores<5:
            clock.tick(30)
        elif scores<20:
            clock.tick(40)
        elif scores<25:
            clock.tick(50)
        elif scores<30:
            clock.tick(60)
        elif scores<40:
            clock.tick(70)
        elif scores<50:
            clock.tick(80)
        elif scores<60:
            clock.tick(90)
        elif scores<70:
            clock.tick(200)
    return game_over()

def count_scores(barriers):
    global scores,max_above
    above_cactus=0
    if -20<=jump_counter<20:
        for barrier in barriers:
            if usr_y+usr_height-5<=barrier.y:
                if barrier.x<=usr_x<=barrier.x+barrier.width:
                    above_cactus+=1
                elif barrier.x<=usr_x+usr_width<=barrier.x+barrier.width:
                    above_cactus+=1
        max_above=max(max_above,above_cactus)
    else:
        if jump_counter==-30:
            scores+=max_above
            max_above=0
def object_return(objects, obj):
    radius=find_radius(objects)
    choice=random.randrange(0,3)
    img=cactus_img[choice]
    width=cactus_options[choice*2]
    height=cactus_options[choice*2+1]
    obj.return_self(radius,height,width,img)
    
            
def check_collision(barriers):
    for barrier in barriers:
        if barrier.y==449:
            if not make_jump:
                if barrier.x<=usr_x+usr_width-20<=barrier.x+barrier.width:
                    if check_health():
                        object_return(barriers, barrier)
                        return False
                    else:
                        return True
                        
            elif jump_counter>=0:
                if usr_y+usr_height-5>=barrier.y:
                    if barrier.x<=usr_x+usr_width-70<=barrier.x+barrier.width:
                        if check_health():
                            object_return(barriers, barrier)
                            return False
                        else:
                            return True
            else:
                if usr_y+usr_height-10>=barrier.y:
                    if barrier.x<=usr_x<=barrier.x+barrier.width:
                        if check_health():
                            object_return(barriers, barrier)
                            return False
                        else:
                            return True
        else:
            if not make_jump:
                if barrier.x<=usr_x+usr_width+0<=barrier.x+barrier.width:
                    if check_health():
                        object_return(barriers, barrier)
                        return False
                    else:
                        return True
            elif jump_counter==10:
                if usr_y+usr_height-5>=barrier.y:
                    if barrier.x<=usr_x+usr_width-5<=barrier.x+barrier.width:
                        if check_health():
                            object_return(barriers, barrier)
                            return False
                        else:
                            return True
            elif jump_counter<=-1:
                if usr_y+usr_height-3>=barrier.y:
                    if barrier.x<=usr_x+34<=barrier.x+barrier.width:
                        if check_health():
                            object_return(barriers, barrier)
                            return False
                        else:
                            return True
                else:
                    if usr_y+usr_height-10>=barrier.y:
                         if barrier.x<=usr_x+5<=barrier.x+barrier.width:
                             if check_health():
                                 object_return(barriers, barrier)
                                 return False
                             else:
                                return True
                    
                
    return False
def game_over():
    pygame.mixer.music.pause()
    global scores,max_scores
    if scores>max_scores:
        max_scores=scores
    
    stopped=True
    while stopped:
        for event in pygame.event.get():
            if event.type==pygame.QUIT:
                pygame.quit()
                quit()
        print_text('Game over. press Esc-stop, enter-try again',104,300)
        print_text('Max scores : '+str(max_scores),300,350)
        keys=pygame.key.get_pressed()
        if keys[pygame.K_RETURN]:
            return True
        if keys[pygame.K_ESCAPE]:
            return False
        pygame.display.update()
        clock.tick(15)
    pygame.mixer.music.unpause()
    

def jump():
    global usr_y,jump_counter,make_jump
    if jump_counter>=-30:
        if jump_counter==-25:
            pygame.mixer.Sound.play(fall_sound)
        usr_y-=jump_counter/4
        jump_counter-=1
    else:
        jump_counter=30
        make_jump=False

def create_cactus_arr(array):
    choice=random.randrange(0,3)
    img=cactus_img[choice]
    width=cactus_options[choice*2]
    height=cactus_options[choice*2+1]
    array.append(Object(display_width+20,height,width,img,4))

    choice=random.randrange(0,3)
    img=cactus_img[choice]
    width=cactus_options[choice*2]
    height=cactus_options[choice*2+1]
    array.append(Object(display_width+300,height,width,img,4))

    choice=random.randrange(0,3)
    img=cactus_img[choice]
    width=cactus_options[choice*2]
    height=cactus_options[choice*2+1]
    array.append(Object(display_width+600,height,width,img,4))
    
    
def draw_array(array):
    for cactus in array:
        check=cactus.move()
        if not check:
            object_return(array, cactus)

def open_random_objects():
    choice=random.randrange(0,2)
    img_of_stone=stone_img[choice]
    choice=random.randrange(0,2)
    img_of_cloud=cloud_img[choice]
    stone=Object(display_width,display_height-80, 10 ,img_of_stone,4)
    cloud=Object(display_width,178, 70 ,img_of_cloud,1)
    return stone,cloud

def move_objects(stone,cloud):
    check=stone.move()
    if not check:
        choice=random.randrange(0,2)
        img_of_stone=stone_img[choice]
        stone.return_self(display_width,random.randrange(10,80)+500,stone.width,img_of_stone)

    check=cloud.move()
    if not check:
        choice=random.randrange(0,2)
        img_of_cloud=cloud_img[choice]
        cloud.return_self(display_width,random.randrange(178,300),cloud.width,img_of_cloud)

def drow_dino():
    global img_counter
    if img_counter==25:
        img_counter=0
    display.blit(dino_img[img_counter//5], (usr_x,usr_y))
    img_counter+=1


def show_health():
    global health
    show=0
    x=10
    while show!= health:
        display.blit(health_img,(x,10))
        x+=40
        show+=1
        
def check_health():
    global health
    health-=1
    if health==0:
        pygame.mixer.Sound.play(loss_sound)
        return False
    else:
        pygame.mixer.Sound.play(fall_sound)
        return True

def heart_plus(heart):
    global health,usr_x,usr_y,usr_width,usr_height
    if heart.x<=-heart.width:
        radius=display_width+random.randrange(500,700)
        heart.return_self(radius,heart.y,heart.width,heart.image)
    if usr_x<=heart.x<=usr_x+usr_width:
        if usr_y<= heart.y<=usr_y+usr_height:
            pygame.mixer.Sound.play(heart_plus_sound)
            if health <5:
                health+=1
            radius=display_width+random.randrange(500,2200)
            heart.return_self(radius,heart.y,heart.width,heart.image)

def check_dino_damage(bullets):
    global usr_x,usr_y,usr_width,usr_height,health
    for bullet in bullets:
        if usr_x<=bullet.x<=usr_x+usr_width-30:
            if usr_y<=bullet.y<=usr_y+usr_height:
                return True
                pass
                

show_menu()
pygame.quit()
quit()
