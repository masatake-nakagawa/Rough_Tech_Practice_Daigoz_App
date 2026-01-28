# AI Coding Assistant Instructions - Rough Tech Practice Daigoz App

## Project Overview
**情報共有アプリ (Information Sharing App)** is a Spring Boot 2.7 / Spring MVC application for a kendo dojo to centralize event scheduling, announcements, and rule documentation.

- **Tech Stack**: Spring Boot 2.7 (Java 21), Spring MVC, Spring Data JPA, PostgreSQL, JSP, Maven
- **Architecture**: Traditional MVC with Repository pattern
- **Database**: PostgreSQL (sampledb_task) with JDBC/JPA integration

## Critical Architecture Patterns

### MVC Layer Organization
```
jp.co.hoge.web/
├── controller/        # 10+ controllers handling requests
├── service/           # 3 services (User, Event, Attendance)
├── repository/        # JPA repositories extending JpaRepository<T, Long>
└── entity/            # JPA entities mapped to database tables
```

**Key Pattern**: Controllers → Services → Repositories
- Controllers use `@RequestMapping`/`@GetMapping`/`@PostMapping`
- Services use `@Service` with `@Autowired` repositories and `@Transactional`
- Repositories extend `JpaRepository<Entity, Long>` with custom query methods

### Dependency Injection Convention
- All beans use field injection via `@Autowired private RepositoryType repository`
- Services are injected into Controllers
- Repositories are injected into Services

### Session & Authentication
- Authentication happens in `AuthController.authenticate()` using `UserInfoRepository.findByLoginIdAndPassword()`
- Session attributes: `user_id`, `login_id`, `user_name`, `role_id`
- Session invalidation in logout endpoint

## Build & Development Workflow

### Maven Builds
```bash
# From original_Spring directory
mvn clean package          # Build WAR file
mvn spring-boot:run        # Run locally on embedded Tomcat
```

### Key Configuration
- **application.properties**: Database connection (PostgreSQL localhost:5432), JSP view prefix/suffix
- **applicationContext.xml**: Message source beans for i18n (`messages_ja.properties`, `ValidationMessages_ja.properties`)
- **JSP Location**: `/src/main/webapp/WEB-INF/views/`
- **Static Assets**: `/src/main/resources/static/` (main.css)

### Database Configuration
```properties
spring.datasource.driver-class-name=org.postgresql.Driver
spring.datasource.url=jdbc:postgresql://localhost:5432/sampledb_task
spring.datasource.username=hogeuser
spring.datasource.password=hoge
```

## Code Conventions & Patterns

### Controller Pattern
- Return view names as Strings (JSP filenames without .jsp)
- Use `Model model` parameter to pass data to views
- Use `@RequestParam` for form parameters
- Inject `HttpSession` for session management
- Validation logic **before** calling service methods

Example:
```java
@PostMapping("/login")
public String authenticate(@RequestParam("loginId") String loginId,
                          @RequestParam("pass") String password,
                          Model model, HttpSession session) {
    if (loginId.isEmpty()) {
        model.addAttribute("errorMessage", "IDは必須です");
        return "login";  // Re-render form with error
    }
    List<UserInfo> users = userInfoRepository.findByLoginIdAndPassword(loginId, password);
    if (users.isEmpty()) {
        model.addAttribute("errorMessage", "IDまたはPASSが間違っています");
        return "login";
    }
    // Success: set session attributes
    UserInfo user = users.get(0);
    session.setAttribute("user_id", user.getUserId());
    session.setAttribute("login_id", loginId);
    session.setAttribute("user_name", user.getUserName());
    session.setAttribute("role_id", String.valueOf(user.getRole().getRoleId()));
    return "redirect:/menu";
}
```

### Service Pattern
- Use `@Transactional` for data modification methods only (create/update/delete)
- Throw `RuntimeException` for business rule violations (e.g., `throw new RuntimeException("ユーザーは存在しません")`)
- Keep services stateless and focused on domain logic
- Query methods (reads) do NOT need `@Transactional`

Example:
```java
@Service
public class UserService {
    @Autowired
    private UserInfoRepository userInfoRepository;
    
    @Transactional
    public void deleteUserByLoginId(String loginId) {
        if (!userInfoRepository.existsByLoginId(loginId)) {
            throw new RuntimeException("ユーザーは存在しません");
        }
        userInfoRepository.deleteByLoginId(loginId);
    }
}
```

### Repository Pattern
- Use JPA query methods: `findBy*`, `existsBy*`, `deleteBy*`
- Leverage Spring Data JPA method name conventions
- Custom `@Query` annotations added as needed (not yet in codebase)
- Always return `List<T>` for potentially multiple results (even if expecting 1 record)

## Important Files & Directories

| Path | Purpose |
|------|---------|
| [original_Spring/pom.xml](original_Spring/pom.xml) | Maven dependencies (Spring Boot 2.7, PostgreSQL, JSP) |
| [original_Spring/src/main/java/jp/co/hoge/web/controller/](original_Spring/src/main/java/jp/co/hoge/web/controller/) | Request handlers (Auth, Event, User, etc.) |
| [original_Spring/src/main/java/jp/co/hoge/web/service/](original_Spring/src/main/java/jp/co/hoge/web/service/) | Business logic (UserService, EventService, AttendanceService) |
| [original_Spring/src/main/java/jp/co/hoge/web/repository/](original_Spring/src/main/java/jp/co/hoge/web/repository/) | Data access layer (User, Event, Attendance, UserInfo repos) |
| [original_Spring/src/main/resources/application.properties](original_Spring/src/main/resources/application.properties) | Database & view config |
| [original_Spring/src/main/webapp/WEB-INF/views/](original_Spring/src/main/webapp/WEB-INF/views/) | JSP templates (~20 pages) |
| [original_Spring/src/main/resources/messages_ja.properties](original_Spring/src/main/resources/messages_ja.properties) | Japanese i18n messages |

## Data Flow Examples

### Login Flow
1. User submits login form → `AuthController.authenticate()`
2. Query via `userInfoRepository.findByLoginIdAndPassword()`
3. Validate credentials, set session attributes
4. Redirect to `/menu` (IndexController.menu())

### Event Management
- EventEditController, EventService, EventRepository handle event CRUD
- Likely integrates with AttendanceService for tracking participation

## Integration Points

### Spring Boot Configuration
- Auto-configured JDBC/JPA DataSource from PostgreSQL properties
- Embedded Tomcat for WAR execution
- Spring MVC servlet dispatcher mapped to JSP views via `spring.mvc.view.prefix/suffix`

### Message Source (i18n)
- `ReloadableResourceBundleMessageSource` bean in applicationContext.xml
- Access in JSP via `<spring:message>` tag or in Java via `MessageSource` injection
- Japanese locale messages in `messages_ja.properties`

## Common Developer Tasks

### Adding a New Endpoint
1. Create or extend Controller class in `/controller/`
2. Add `@GetMapping` or `@PostMapping` method
3. Inject required Service via `@Autowired`
4. Call service methods to fetch/mutate data
5. Return view name or redirect
6. Create corresponding JSP file in `/WEB-INF/views/`

### Adding a New Entity & Repository
1. Create Entity class in `/entity/` with JPA `@Entity` annotation
2. Create Repository interface extending `JpaRepository<Entity, Long>`
3. Create Service if business logic needed
4. Update controller to use service

### Debugging Tips
- Check PostgreSQL connection in application.properties
- Verify session attributes are set in AuthController
- JSP view resolution depends on `spring.mvc.view.prefix/suffix` config
- Use Maven debug output for classpath issues

## Special Notes
- Project written in **Japanese** - property names, entity names, and error messages use Japanese
- Uses **Spring Data JPA** (not pure Hibernate) for ORM
- JSP-based UI (not Thymeleaf or modern SPA)
- Role-based access likely via `role_id` from session (UserInfo.getRole().getRoleId())

## Typical Development Workflow for New Features

### Scenario: Add "Delete Event" Feature
1. **Create Controller method**:
   ```java
   @PostMapping("/event/delete")
   public String deleteEvent(@RequestParam Long eventId, HttpSession session, Model model) {
       Long userId = (Long) session.getAttribute("user_id");
       try {
           eventService.deleteEvent(eventId, userId);  // Authorization check inside
           model.addAttribute("message", "イベント削除完了");
           return "redirect:/event/list";
       } catch (RuntimeException e) {
           model.addAttribute("errorMessage", e.getMessage());
           return "forward:/event/list";
       }
   }
   ```

2. **Add Service method** (with `@Transactional`):
   ```java
   @Transactional
   public void deleteEvent(Long eventId, Long userId) {
       Event event = eventRepository.findById(eventId)
           .orElseThrow(() -> new RuntimeException("イベントが見つかりません"));
       if (!isAdminOrCreator(userId, event)) {
           throw new RuntimeException("削除権限がありません");
       }
       eventRepository.deleteById(eventId);
   }
   ```

3. **Repository method** (if custom query needed):
   ```java
   void deleteById(Long eventId);  // Already provided by JpaRepository
   Optional<Event> findById(Long eventId);  // Already provided
   ```

4. **Create JSP confirmation** (optional):
   - Add form to `/WEB-INF/views/eventList.jsp` with POST to `/event/delete`

## Critical Integration Points

### Session-Based Authorization (NOT @Secured)
- Always check `(Long)session.getAttribute("user_id")` in controllers/services
- Admin check via `String roleId = (String)session.getAttribute("role_id")`
- If role_id is "1" (admin) or "2" (member), grant/deny access accordingly
- Throw `RuntimeException` if user lacks permission

### Database Transaction Management
- `@Transactional` on Service methods ensures `commit` on success / `rollback` on exception
- All persistence ops inside `@Transactional` methods become atomic
- No explicit `session.flush()` or `entityManager` needed—handled by Spring

### JSP-to-Model Data Binding
- Controller puts objects in `Model`: `model.addAttribute("events", list);`
- JSP accesses via EL: `${events}` or JSTL `<c:forEach items="${events}" var="event">`
- Form parameters auto-bound to `@RequestParam` (Spring parses HTTP request)

## Testing & Validation Approach

- **Manual testing**: Start app with `mvn spring-boot:run`, test in browser at `http://localhost:8080`
- **Database setup**: Ensure PostgreSQL is running; check `backup_sampledb.sql` for schema
- **Error messages**: All user-facing messages should be in Japanese (consistency with existing i18n)
- **Session validation**: Test login flow to ensure session attributes persist across requests

