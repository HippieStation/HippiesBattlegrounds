/*
var/const/ENGSEC			=(1<<0)

var/const/CAPTAIN			=(1<<0)
var/const/IHC				=(1<<1)
var/const/GUNSERG			=(1<<2)
var/const/INSPECTOR			=(1<<3)
var/const/IHOPER			=(1<<4)
var/const/MEDSPEC			=(1<<5)
var/const/CHIEF				=(1<<6)
var/const/ENGINEER			=(1<<7)
var/const/ATMOSTECH			=(1<<8)
var/const/AI				=(1<<9)
var/const/CYBORG			=(1<<10)


var/const/MEDSCI			=(1<<1)

var/const/RD				=(1<<0)
var/const/SCIENTIST			=(1<<1)
var/const/CHEMIST			=(1<<2)
var/const/CMO				=(1<<3)
var/const/DOCTOR			=(1<<4)
var/const/GENETICIST		=(1<<5)
var/const/VIROLOGIST		=(1<<6)
var/const/PSYCHIATRIST		=(1<<7)
var/const/ROBOTICIST		=(1<<8)
var/const/XENOBIOLOGIST		=(1<<9)
var/const/PARAMEDIC			=(1<<10)


var/const/CIVILIAN			= (1<<2)

var/const/HOP				=(1<<0)
var/const/BARTENDER			=(1<<1)
var/const/BOTANIST			=(1<<2)
var/const/CHEF				=(1<<3)
var/const/JANITOR			=(1<<4)
var/const/LIBRARIAN			=(1<<5)
var/const/QUARTERMASTER		=(1<<6)
var/const/CARGOTECH			=(1<<7)
var/const/MINER				=(1<<8)
var/const/LAWYER			=(1<<9)
var/const/CHAPLAIN			=(1<<10)
var/const/CLOWN				=(1<<11)
var/const/MIME				=(1<<12)
var/const/ASSISTANT			=(1<<13)


// WW2
var/const/METRO				=(1<<0) //Equal to ENGSEC

var/const/TRADER			=(1<<0)

var/const/GERSOL			=(1<<14)
var/const/GEROFF			=(1<<15)
var/const/GERMED			=(1<<16)
var/const/GERSER			=(1<<17)
var/const/GERENG			=(1<<18)
var/const/GERSOND			=(1<<19)
var/const/GERSNI			=(1<<20)
var/const/GERFALL			=(1<<21)
var/const/GERQUAR			=(1<<22)

var/const/SOVSOL			=(1<<23)
var/const/SOVOFF			=(1<<24)
var/const/SOVMED			=(1<<25)
var/const/SOVSER			=(1<<26)
var/const/SOVENG			=(1<<27)
var/const/SOVSOND			=(1<<28)
var/const/SOVQUAR			=(1<<29)
*/
var/list/assistant_occupations = list(
)


var/list/command_positions = list(
	"Captain",
	"First Officer",
	"Ironhammer Commander",
	"Chief Engineer",
	"Research Director",
	"Chief Medical Officer"
)


var/list/engineering_positions = list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospheric Technician",
)


var/list/medical_positions = list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Geneticist",
	"Psychiatrist",
	"Chemist",
	"Paramedic"
)


var/list/science_positions = list(
	"Research Director",
	"Scientist",
	"Geneticist",	//Part of both medical and science
	"Roboticist",
	"Xenobiologist"
)

//BS12 EDIT
var/list/cargo_positions = list(
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner"
)

var/list/civilian_positions = list(
	"First Officer",
	"Bartender",
	"Gardener",
	"Chef",
	"Janitor",
	"Librarian",
	"Monochurch Preacher",
	"Assistant"
)


var/list/security_positions = list(
	"Ironhammer Commander",
	"Gunnery Sergeant",
	"Medical Specialist",
	"Inspector",
	"Ironhammer Operative"
)


var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"pAI"
)


/proc/guest_jobbans(var/job)
	return ((job in command_positions) || (job in nonhuman_positions) || (job in security_positions))

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(J.title == job)
			titles = J.alt_titles

	return titles
