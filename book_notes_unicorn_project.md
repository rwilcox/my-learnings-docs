---
path: /book_notes/book_notes_unicorn_project
title: 'Book Notes: Unicorn Project'
---
# On Developer Experience



> "We don't have a standard Dev environment that developers can use. It takes months for new developers to do builds on their laptops and be fully productive. Even our build server is woefully under-documented."
> 
> - From The Unicorn Project by Gene Kim on page 15 ()


> Without constant fedback from a centralized build, integration and test system they really have no idea what will happen when all their work is merged with everyone else's
> 
> - From The Unicorn Project by Gene Kim on page 17 ()


> Something even more important than code: the systems that enable developers to be productive, so that they can write high quality code quickly and safely, freeing themselves from all the things that prevent them from solving business problems.
> 
> - From The Unicorn Project by Gene Kim on page 22 ()


> but if we want developers to be productive, they need to be able to perform production builds on Day One.
> 
> - From The Unicorn Project by Gene Kim on page 39 ()


> [the documentation] painfully assembled Phoenix build instructions, complete with links to documents, license keys, step by step tutorials, and even links to a bunch of videos.
> 
> - From The Unicorn Project by Gene Kim on page 68 ()


> but one thing we all agree on is that getting builds going again is one of the most urgent and important engineering practices we need right now. Once we get continous builds going we can enable automated testing. We get automated testing, we can make changes quicker, with more confidence and without having to depend on hundreds of hours of manual testing
> 
> - From The Unicorn Project by Gene Kim on page 99 ()


> "The importance of lead times in software delivery is tantamonth, as Dr. Nicole Forsgren and Jez Humble have discovered in research." Erik says. "Code deployment, lead time, code deployment frequency, and time to resolve problems and predictive of software delivry, operational performance, organizational performance, and they correlate with burnout, employee engagement and so much more."
> 
> - From The Unicorn Project by Gene Kim on page 106 ()


> [Developers] can't directly access [anything operationally about prod] they can't see what's going on, and the only way they can understand what's actually happening is to talk to someone in Opertions through the ticketing system. [and that makes outages longer]
> 
> - From The Unicorn Project by Gene Kim on page 126 ()


> More importantly, Purna and the QA teams are using the Data Hub environment as well: once features are flagged "Ready for Test" they're tested within hours. And because tests are being checked in with the code themselves it's easy for the developer to quickly reproduce the problem.
> 
> - From The Unicorn Project by Gene Kim on page 178 ()


> Surely creating huge productivity dividends long in the future, allowing developers to keep moving fast, getting even faster feedback on errors. It's like the opposite of technical debt. It's like when compounding interest works in your favore. If they could make developers a little more productive all the time, it would always pay off in spades.
> 
> - From The Unicorn Project by Gene Kim on page 278 ()

# Scaling / releasing to prod


> "How many transactions per second are we expecting for product displays and orders? And how many transactions per seconds are the current builds capable of handling right now? That will tell us how many servers we need for horizontally scalable portions, as well as how far we're off for the vertically scaled components, like the database"
> 
> - From The Unicorn Project by Gene Kim on page 62 ()


# Working in enterprises


> Maxine suddenly becomes alarmed at just _how many people_ are required to create one environment.
> 
> - From The Unicorn Project by Gene Kim on page 52 ()




> Almost everything I need to do, I have to do up two levels, over two levels, and down two levels just to talk with a fellow engineer!
> ...
> I want to bring back the days when a developers could actually create value for someone that cares, easily and quickly.
> 
> - From The Unicorn Project by Gene Kim on page 78 ()



> Left to their own devices, development teams will often optimize everything around themselves. This is just parochial and selfish nature of individual teams. _And that's why you need architects_, thinks Maxine.
> 
> - From The Unicorn Project by Gene Kim on page 247 ()

# Five Ideals / 3 Horizons


> I've started calling all these things "complexity debt" because they're not just technical issues - they're business issues. And it's always a choice" he says. "You can choose to build new features or you can choose to pay down complexity debt"
> 
> - From The Unicorn Project by Gene Kim on page 108 ()


> There are five ideas:
> * First Ideal - Locality and Simplicity
> * Second Ideal - Focus, Flow and Joy
> * Third Ideal - Improvement of Daily Work
> * Fourth Ideal - Psychological Safety
> * Fifth Ideal - Customer Focus
> 
> - From The Unicorn Project by Gene Kim on page 108 ()


> First ideal of locality: We need to design things so that we have locality in our systems and the organizations that build them. And we need simplicity in everything we do. The last place we want complexity is internally, whether it's in our code, in our organization or in our process. The external world is complex enough, so it will be intolerable if we allow it in things we actually control!
> 
> - From The Unicorn Project by Gene Kim on page 109 ()


> The second ideal is focus, flow and joy. It's all about how much our daily work feels. Is our work marked by boredom and waiting for other people to get things done on our behalf? Do we blindly work on small pieces of the whole, only seeing outcomes of our work during a deployment when everything blows up, leading to firefighting, punishment and burnout?
> 
> - From The Unicorn Project by Gene Kim on page 110 ()


> The third ideal is improvement of daily work.
> - From The Unicorn Project by Gene Kim on page 110 ()

My thoughts: 



> Fourth ideal is psycological safety, where we make it safe to talk about problems, because solving problems requires prevention, which requires honesty, and honesty requires the absence of fear.
> 
> - From The Unicorn Project by Gene Kim on page 110 ()


> Fifth ideal is customer focus, where we ruthlessly question whether something actually matters to our customers as in, are they willing to pay us for it or is it only of value to our functional silo?
> 
> - From The Unicorn Project by Gene Kim on page 110 ()



> The fifth ideal is about a ruthless Customer Focus, where you are truely striving for what's best for them, instead of the more parochial goals that they don't care about, whether it's your internal plans of record or how your functional silos are measured. he say. Instead we ask whether our daily actions truely improve the lives of our customer, create value for them, and whether they'd pay for it. And if they don't, maybe we should't be doing it at all.
> 
> - From The Unicorn Project by Gene Kim on page 262 ()


> The concepts of horizons 1, 2, and 3 were popularized by Dr. Geoffrey Morre, who is most famous for his book _Crossing the Chasm_.
> 
> - From The Unicorn Project by Gene Kim on page 269 ()


> Horizon 1 is your successful, cash cow where the business and operating models are predictable and well-known.
> 
> - From The Unicorn Project by Gene Kim on page 269 ()


> Horizon 2 lines of business are so important, because they represent the future of the company. They may introduce the company's capabilites to new customers, adjacent markets, or with different business models.
> 
> - From The Unicorn Project by Gene Kim on page 270 ()


> You may have guessed that Horizon 2 efforts come from Horizon 3, where the focus is on velocity of learning and having a broad pool of ideas to explore. Here the name of the game is to prototype ideas and to answer quickly as possible the three questions of market risk, technical risk and business model risk. Does the idea solve a real customer need? Is it technicall feasible? And is there a finanially feasible engine of growth? If the answer is _no_ to any of them, it's time to pivot or kill the idea.
> 
> - From The Unicorn Project by Gene Kim on page 270 ()


> In contrast, Horizon 3, you must go fast, you must be constantly experimenting and you must be allowed to break all the rules governing Horizon
> 
> - From The Unicorn Project by Gene Kim on page 270 ()

# MVPs

> Although Debra frets about the manual process, Maxine knows that this is all about creating a Mimimum Viable Product to test their offerings and confirm their hypothesis of what capabilites are required to fufil them. This rapid iteration and learning because they invest heality in rolling out a big, disruptive process is a great example of the Third Ideal of Improvement of Daily Work.
> 
> - From The Unicorn Project by Gene Kim on page 309 ()

# Developer careers


> She was doing to be the first distinquished engineer in the company's history, reporting directly to Bill. Amoung other things, her charter is to help create a culture of engineering excellence across the company. She'll regularly meet with the top company leadership to understand their goals and strategize on how technology can be used to achieve those goals, which of course helps the company win in the marketplace.
> Maxine is excited that there is funally a career ladder for individual contributors and brilliant technolgiests without having to become managers.
> 
> - From The Unicorn Project by Gene Kim on page 330 ()

# Transformed Enterprises

> Ops is quickly turning into a platform team and internal consultants, with the goals of providing developers the infrastructure they need, complete with a vast army of experts who are there to help, looking for ways to make developers productive.
> 
> - From The Unicorn Project by Gene Kim on page 330 ()

