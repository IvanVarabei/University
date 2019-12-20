import pygame
import random
from globalVars import *
from bird import Bird
pygame.init()


def print_text(message,x,y,font_color=(0,0,0), font_type='PingPong.ttf', font_size=30):
    font_type=pygame.font.Font(font_type,font_size)
    text=font_type.render(message, True,font_color)
    display.blit(text,(x,y))

def find_radius(array):
    maximum=max(array[0].x,array[1].x,array[2].x)
    if maximum<display_width:
        radius=display_width
        if radius-maximum<50:
            radius+=280
    else:
        radius=maximum
    choice=random.randrange(0,5)
    if choice==0:
        radius+=random.randrange(15,25)
    else:
        radius+=random.randrange(250,400)
    return radius

def pause():
    paused=True
    pygame.mixer.music.pause()
    while paused:
        for event in pygame.event.get():
            if event.type==pygame.QUIT:
                pygame.quit()
                quit()
        print_text('Paused. Press enter to continue.',160,300)
        keys=pygame.key.get_pressed()
        if keys[pygame.K_RETURN]:
            paused=False
        pygame.display.update()
        clock.tick(60)
    pygame.mixer.music.unpause()

def draw_birds(birds):
    for bird in birds:
        action=bird.draw()
        if action==1:
            bird.show()
        elif action==2:
            bird.hide()
        else:
            if bird.y>0:
                bird.shoot()


def check_birds_dmg(bullets,birds):
    for bird in birds:
        for bullet in bullets:
            bird.check_damage(bullet)


def draw_mouse():
    global mouse_counter, need_draw_click
    mouse=pygame.mouse.get_pos()
    click=pygame.mouse.get_pressed()
    mouse_size=[10,12,16,20,28,34,40,45,54,58]
    if click[0] or click[1]:
        need_draw_click=True
    if need_draw_click:
        draw_x=mouse[0]-mouse_size[mouse_counter]//2
        draw_y=mouse[1]-mouse_size[mouse_counter]//2
        display.blit(light_img[mouse_counter],(draw_x,draw_y))
        mouse_counter+=1
        if mouse_counter==10:
            mouse_counter=0
            need_draw_click=False


        
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


def object_return(objects, obj):
    radius=find_radius(objects)
    choice=random.randrange(0,3)
    img=cactus_img[choice]
    width=cactus_options[choice*2]
    height=cactus_options[choice*2+1]
    obj.return_self(radius,height,width,img)

